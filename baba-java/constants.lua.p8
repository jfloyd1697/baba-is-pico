__lua__

Blocks = require('Blocks')

LEGEND = {
  ['_'] = Blocks.BLANK,
  ['b'] = Blocks.ICONS.Baba,
  ['r'] = Blocks.ICONS.Rock,
  ['w'] = Blocks.ICONS.Wall,
  ['f'] = Blocks.ICONS.Flag,
  ['k'] = Blocks.ICONS.Skull,
  ['h'] = Blocks.ICONS.Water,
  ['B'] = Blocks.NOUNS.Baba,
  ['R'] = Blocks.NOUNS.Rock,
  ['W'] = Blocks.NOUNS.Wall,
  ['F'] = Blocks.NOUNS.Flag,
  ['K'] = Blocks.NOUNS.Skull,
  ['H'] = Blocks.NOUNS.Water,
  ['s'] = Blocks.JOINERS.Is,
  ['P'] = Blocks.PROPERTIES.Push,
  ['S'] = Blocks.PROPERTIES.Stop,
  ['U'] = Blocks.PROPERTIES.You,
  ['!'] = Blocks.PROPERTIES.Win,
  ['X'] = Blocks.PROPERTIES.Defeat,
  ['@'] = Blocks.PROPERTIES.Sink
}

EFFECTS = {
  SOLID = 'solid',
  MOVABLE = 'movable',
  YOU = 'you',
  WIN = 'win',
  DEFEAT = 'defeat',
  SINK = 'sink',
  HOT = 'hot',
  MELT = 'melt'
}

TYPES = {
  BASE = 'base',
  BLANK = 'blank',
  ICON = 'icon',
  NOUN = 'noun',
  JOINER = 'joiner',
  PROPERTY = 'property'
}

INPUTS = {
  UP = 0,
  RIGHT = 1,
  DOWN = 2,
  LEFT = 3,
  UNDO = 4,
  RESET = 5
}