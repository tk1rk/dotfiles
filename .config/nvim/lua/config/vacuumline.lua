require('vacuumline').setup({
  theme = {
    line             = {foreground = '#69ff94', background = '#282828'},
    segment_odd      = {foreground = '#44475a', background = '#b16286'},
    segment_even     = {foreground = '#44475a', background = '#98971a'},
    mode_normal      = {foreground = '#ff79c6'},
    mode_insert      = {foreground = '#50fa7b'},
    mode_command     = {foreground = '#8be9fd'},
    mode_visual      = {foreground = '#ffb86c'},
    mode_visual_line = {foreground = '#50fa7b'},
    mode_terminal    = {foreground = '#bd93f9'},
    warning          = {foreground = '#44475a', background = '#fabd2f'},
    error            = {foreground = '#ff6e6e', background = '#fb4934'},
    scroll           = {foreground = '#ffb86c'}
  },
  separator = {
    segment = {
      left = '',
      right = ''
    },
    section = {
      left = '',
      right = ''
    }
  },
  color = {
    foreground = {line = '#ff79c6', even = '#44475a', odd = '#44475a'},
    background = {line = '#44475a', even = '#50fa7b', odd = '#ff79c6'},
  },
  segment = {
    mode = {
      map = {
        n = {label = ' ', background = '#ff92df'}, -- NORMAL
        i = {label = ' ', background = '#50fa7b'}, -- INSERT
        c = {label = ' ', background = '#4891A4'}, -- COMMAND
        v = {label = ' ', background = '#ffb86c'}, -- VISUAL
        V = {label = ' ', background = '#F59D18'}, -- VISUAL LINE
        t = {label = ' ', background = '#ff79c6'}, -- TERMINAL
      }
    },
    file = {},
    vcs = {},
    scroll = {
      accent = '#d79921',
    },
    lines = {},
    diagnostics = {
      background = '#fb4934',
      errors = {
        foreground = '#282828',
        background = '#fb4934'
      },
      warnings = {
        foreground = '#282828',
        background = '#fabd2f'
      }
    },
    search = {},
    lsp = {
      foreground = '#98971a',
      background = '#282828'
    }
  }
}
})
