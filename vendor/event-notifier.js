var widgetIntroduction = new Bounce();
widgetIntroduction
  .translate({
    from: { x: 0, y: -90 },
    to: { x: 0, y: 0 }
  })
  .rotate({
    from: -180,
    to: 0
  })
  .define('animate-square-in');
