local animate = require("mini.animate")

animate.setup(
{
  -- Cursor path
  cursor = {
    -- Whether to enable this animation
    enable = false,

    -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,

    -- Path generator for visualized cursor movement
   -- path = --<function: implements shortest line path no longer than 1000>,
  },

  -- Vertical scroll
  scroll = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
    subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
  },

  -- Window resize
  resize = {
    -- Whether to enable this animation
    enable = false,

    -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,

    -- Subresize generator for all steps of resize animations
    -- subresize = --<function: implements equal linear steps>,
  },

  -- Window open
  open = {
    -- Whether to enable this animation
    enable = false,

    -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,

    -- Floating window config generator visualizing specific window
    -- winconfig = --<function: implements static window for 25 steps>,

    -- 'winblend' (window transparency) generator for floating window
    -- winblend = --<function: implements equal linear steps from 80 to 100>,
  },

  -- Window close
  close = {
    -- Whether to enable this animation
    enable = false,

    -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,

    -- Floating window config generator visualizing specific window
    -- winconfig = --<function: implements static window for 25 steps>,

    -- 'winblend' (window transparency) generator for floating window
    -- winblend = --<function: implements equal linear steps from 80 to 100>,
  },
})
