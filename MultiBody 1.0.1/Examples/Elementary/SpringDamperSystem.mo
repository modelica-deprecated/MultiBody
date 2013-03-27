encapsulated model SpringDamperSystem "Simple spring/damper/mass system"
  import Modelica.Icons;
  import MultiBody;
  import Modelica.Mechanics.Rotational;
  import Modelica;
  extends Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  annotation(
    experiment(StopTime=10),
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0,
      width=0.71,
      height=0.85),
    Diagram,
    Documentation(info="<html>
<p>
This example demonstrates:
</p>
<ul>
<li>The animation of spring and damper components</li>
<li>A body can be freely moving without any connection to a joint.
    In this case body coordinates are used automatically as
    states (whenever joints are present, it is first tried to
    use the generalized coordinates of the joints as states).</li>
<li>If a body is freely moving, the initial position and velocity of the body
    can be defined with the \"Initialization\" menu as shown with the
    body \"body1\" in the left part (click on \"Initialization\").</li>
</ul>
<p align=\"center\">
<IMG SRC=\"../Images/Examples/Elementary/SpringDamperSystem.png\"
ALT=\"model Examples.Elementary.SpringDamperSystem\">
</p>
</html>"));
  inner MultiBody.World world annotation( extent=[-80, 20; -60, 40]);
  MultiBody.Parts.Body body1(
    m=1,
    animation=animation,
    initType=MultiBody.Types.Init.PositionVelocity,
    r_0_start={0.3,-0.2,0},
    r_CM={0,-0.2,0},
    w_0_start={0,0,2},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1) annotation( extent=[-10, -60; -30, -40], rotation=-90);
  MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation( extent=[-46, 20; -26, 40]);
  MultiBody.Parts.FixedTranslation bar2(animation=animation, r={0.6,0,0})
    annotation( extent=[0, 20; 20, 40]);
  MultiBody.Parts.Body body2(
    m=1,
    animation=animation,
    cylinderDiameter=0.05,
    sphereDiameter=0.15) annotation( extent=[60, -60; 40, -40], rotation=-90);
  MultiBody.Joints.ActuatedPrismatic p2(
    initType=MultiBody.Types.Init.PositionVelocity,
    n={0,-1,0},
    s_offset=0.1,
    animation=animation,
    enforceStates=true,
    boxWidth=0.05) annotation( extent=[40, -20; 60, 0], rotation=-90);
  MultiBody.Forces.Spring spring2(
    c=30,
    s_unstretched=0.1,
    coilWidth=0.01,
    width=0.1) annotation( extent=[80, -20; 100, 0], rotation=-90);
  MultiBody.Forces.Spring spring1(
    s_unstretched=0.1,
    coilWidth=0.01,
    c=30,
    numberOfWindings=10,
    width=0.1) annotation( extent=[-16, -20; 4, 0], rotation=-90);
  MultiBody.Forces.Damper damper1(d=2)
    annotation( extent=[-40, -20; -20, 0], rotation=-90);
equation
  connect(world.frame_b, bar1.frame_a)
    annotation( points=[-59, 30; -47, 30], style(color=0, thickness=2));
  connect(bar1.frame_b, bar2.frame_a)
    annotation( points=[-25, 30; -1, 30], style(color=0, thickness=2));
  connect(bar2.frame_b, p2.frame_a)
    annotation( points=[21, 30; 50, 30; 50, 1], style(color=0, thickness=2));
  connect(p2.frame_b, body2.frame_a)
    annotation( points=[50, -21; 50, -39], style(color=0, thickness=2));
  connect(bar2.frame_b, spring2.frame_a)
    annotation( points=[21, 30; 90, 30; 90, 1], style(color=0, thickness=2));
  connect(body2.frame_a, spring2.frame_b) annotation( points=[50, -39; 90, -39;
         90, -21], style(color=0, thickness=2));
  connect(damper1.frame_a, bar1.frame_b) annotation( points=[-30, 1; -30, 10; -20,
         10; -20, 30; -25, 30], style(color=0, thickness=2));
  connect(spring1.frame_a, bar1.frame_b) annotation( points=[-6, 1; -6, 10; -20,
         10; -20, 30; -25, 30], style(color=0, thickness=2));
  connect(damper1.frame_b, body1.frame_a) annotation( points=[-30, -21; -30, -28;
         -20, -28; -20, -39], style(color=0, thickness=2));
  connect(spring1.frame_b, body1.frame_a) annotation( points=[-6, -21; -6, -28;
         -20, -28; -20, -39], style(color=0, thickness=2));
end SpringDamperSystem;
