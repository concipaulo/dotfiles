class Registers(Dashboard.Module):
    '''Show the CPU registers and their values.'''

    def __init__(self):
        self.table = {}

    def label(self):
        return 'Registers'

    def lines(self, term_width, term_height, style_changed):
        # skip if the current thread is not stopped
        if not gdb.selected_thread().is_stopped():
            return []
        # obtain the registers to display
        if style_changed:
            self.table = {}
        if self.register_list:
            register_list = self.register_list.split()
        else:
            register_list = Registers.fetch_register_list()
        # fetch registers status
        registers = []
        for name in register_list:
            # Exclude registers with a dot '.' or parse_and_eval() will fail
            if '.' in name:
                continue
            value = gdb.parse_and_eval('${}'.format(name))
            string_value = Registers.format_value(value)
            changed = self.table and (self.table.get(name, '') != string_value)
            self.table[name] = string_value
            registers.append((name, string_value, changed))
        # compute lengths considering an extra space between and around the
        # entries (hence the +2 and term_width - 1)
        max_name = max(len(name) for name, _, _ in registers)
        max_value = max(len(value) for _, value, _ in registers)
        max_width = max_name + max_value + 2
        columns = min(int((term_width - 1) / max_width) or 1, len(registers))
        rows = int(math.ceil(float(len(registers)) / columns))
        # build the registers matrix
        if self.column_major:
            matrix = list(registers[i:i + rows] for i in range(0, len(registers), rows))
        else:
            matrix = list(registers[i::columns] for i in range(columns))
        # compute the lengths column wise
        max_names_column = list(max(len(name) for name, _, _ in column) for column in matrix)
        max_values_column = list(max(len(value) for _, value, _ in column) for column in matrix)
        line_length = sum(max_names_column) + columns + sum(max_values_column)
        extra = term_width - line_length
        # compute padding as if there were one more column
        base_padding = int(extra / (columns + 1))
        padding_column = [base_padding] * columns
        # distribute the remainder among columns giving the precedence to
        # internal padding
        rest = extra % (columns + 1)
        while rest:
            padding_column[rest % columns] += 1
            rest -= 1
        # format the registers
        out = [''] * rows
        for i, column in enumerate(matrix):
            max_name = max_names_column[i]
            max_value = max_values_column[i]
            for j, (name, value, changed) in enumerate(column):
                name = ' ' * (max_name - len(name)) + ansi(name, R.style_low)
                style = R.style_selected_1 if changed else ''
                value = ansi(value, style) + ' ' * (max_value - len(value))
                padding = ' ' * padding_column[i]
                item = '{}{} {}'.format(padding, name, value)
                out[j] += item
        return out

    def attributes(self):
        return {
            'column-major': {
                'doc': 'Show registers in columns instead of rows.',
                'default': False,
                'name': 'column_major',
                'type': bool
            },
            'list': {
                'doc': '''String of space-separated register names to display.
The empty list (default) causes to show all the available registers.''',
                'default': '',
                'name': 'register_list',
            }
        }

    @staticmethod
    def format_value(value):
        try:
            if value.type.code in [gdb.TYPE_CODE_INT, gdb.TYPE_CODE_PTR]:
                int_value = to_unsigned(value, value.type.sizeof)
                value_format = '0x{{:0{}x}}'.format(2 * value.type.sizeof)
                return value_format.format(int_value)
        except (gdb.error, ValueError):
            # convert to unsigned but preserve code and flags information
            pass
        return str(value)

    @staticmethod
    def fetch_register_list(*match_groups):
        names = []
        for line in run('maintenance print register-groups').split('\n'):
            fields = line.split()
            if len(fields) != 7:
                continue
            name, _, _, _, _, _, groups = fields
            if not re.match('\w', name):
                continue
            for group in groups.split(','):
                if group in (match_groups or ('general',)):
                    names.append(name)
                    break
        return names
