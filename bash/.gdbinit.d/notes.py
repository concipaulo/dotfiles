from datetime import datetime

class Notes(Dashboard.Module):
    '''Simple user-defined notes.'''

    def __init__(self):
        self.notes = []

    def label(self):
        return 'Notes'

    def lines(self, term_width, term_height, style_changed):
        out = []
        for index, (ts, note) in enumerate(self.notes):
            # format the index
            index = ansi(str(index), R.style_selected_1)
            line = '[{}]'.format(index)
            # optionally add the timestamp
            if self.timestamp:
                ts = ts.strftime('%Y-%m-%d %H:%M:%S')
                line += ' {} '.format(ansi(ts, R.style_high))
            # finally add the note
            line += ' {}'.format(note)
            out.append(line)
        return out

    def add(self, arg):
        if arg:
            self.notes.append((datetime.now(), arg))
        else:
            raise Exception('Cannot add an empty note')

    def drop(self, arg):
        if arg:
            index = int(arg)
            del self.notes[index]
        else:
            raise Exception('Specify the note index')

    def clear(self, arg):
        self.notes = []

    def commands(self):
        return {
            'add': {
                'action': self.add,
                'doc': 'Add a note.'
            },
            'drop': {
                'action': self.drop,
                'doc': 'Remove a note by index.'
            },
            'clear': {
                'action': self.clear,
                'doc': 'Remove all the notes.'
            }
        }

    def attributes(self):
        return {
            'timestamp': {
                'doc': 'Show the timestamp along with the note.',
                'default': True,
                'type': bool
            }
        }
