encapsulated model Engine "Model of one cylinder engine"
  import Modelica.Icons;
  import Modelica.Mechanics.Rotational;
  import MultiBody;
  import SI = Modelica.SIunits;
  extends Icons.Example;
  annotation (
    experiment(StopTime=5),
    Diagram,
    Coordsys(
      extent=[-100, -120; 150, 120],
      grid=[1, 1],
      component=[20, 20]),
    Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
The combustion is not modelled. The \"inertia\" component at the lower
left part is the output inertia of the engine driving the gearbox.
The angular velocity of the output inertia has a start value of 10 rad/s
in order to demonstrate the movement of the engine.
</p>
<p>
The engine is modeled solely by revolute and prismatic joints.
Since this results in a <b>planar</b> loop there is the well known
difficulty that the cut-forces perpendicular to the loop cannot be
uniquely computed, as well as the cut-torques within the plane.
This ambiguity is resolved by using the option <b>planarCutJoint</b>
in the <b>Advanced</b> menu of one revolute joint in every planar loop
(here: joint B1). This option sets the cut-force in direction of the
axis of rotation, as well as the cut-torques perpendicular to the axis
of rotation at this joint to zero and makes the problem mathematically
well-formed.
</p>
</html>"));
  MultiBody.Parts.BodyCylinder Piston(diameter=0.1, r={0,-0.1,0})
    annotation (extent=[121, 50; 60, 71], rotation=270);
  MultiBody.Parts.BodyBox Rod(
    widthDirection={1,0,0},
    width=0.02,
    height=0.06,
    r={0,-0.2,0},
    color={0,0,200}) annotation (extent=[80, 9; 100, -11], rotation=90);
  MultiBody.Joints.Revolute B2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (extent=[80, 16; 100, 36], rotation=0);
  MultiBody.Joints.ActuatedRevolute Bearing(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (extent=[-10, -70; 10, -90], rotation=0);
  inner MultiBody.World world annotation (extent=[-50, -90; -30, -70]);
  Rotational.Inertia Inertia(phi(
      stateSelect=StateSelect.always,
      fixed=true,
      start=0), w(
      stateSelect=StateSelect.always,
      fixed=true,
      start=10)) annotation (extent=[-51, -120; -31, -100]);
  MultiBody.Parts.BodyBox Crank4(
    height=0.05,
    widthDirection={1,0,0},
    width=0.02,
    r={0,-0.1,0}) annotation (extent=[105.5, -61; 125.5, -81], rotation=90);
  MultiBody.Parts.BodyCylinder Crank3(r={0.1,0,0}, diameter=0.03) annotation (
    extent=[83.5, -70; 103.5, -50],
    rotation=0,
    style(color=0, thickness=2));
  MultiBody.Parts.BodyCylinder Crank1(diameter=0.05, r={0.1,0,0})
    annotation (extent=[24, -90; 44, -70], rotation=0);
  MultiBody.Parts.BodyBox Crank2(
    r={0,0.1,0},
    height=0.05,
    widthDirection={1,0,0},
    width=0.02) annotation (extent=[60, -80; 80, -60], rotation=90);
  MultiBody.Joints.Revolute B1(
    n={1,0,0},
    planarCutJoint=true,
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (extent=[80, -36; 100, -16], rotation=0);
  MultiBody.Parts.FixedTranslation Mid(r={0.05,0,0})
    annotation (extent=[70, -55; 90, -35]);
  MultiBody.Joints.Prismatic Cylinder(
    n={0,1,0},
    s_start=-0.25,
    boxWidth=0.02) annotation (extent=[80, 80; 100, 100], rotation=-90);
  MultiBody.Parts.FixedTranslation cylPosition(r={0.15,0.55,0}, animation=false)
    annotation (extent=[-0.5, 100; 19.5, 120]);
equation
  connect(world.frame_b, Bearing.frame_a)
    annotation (points=[-29, -80; -11, -80], style(color=0, thickness=2));
  connect(Crank2.frame_a, Crank1.frame_b) annotation (points=[70, -81; 57.25, -81;
         57.25, -80; 45, -80], style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Crank2.frame_b, Crank3.frame_a) annotation (points=[70, -59; 75.75, -59;
         75.75, -60; 82.5, -60], style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Bearing.frame_b, Crank1.frame_a) annotation (points=[11, -80; 23, -80],
       style(
      color=0,
      thickness=2,
      fillColor=8,
      fillPattern=1));
  connect(Crank2.frame_b, Mid.frame_a) annotation (points=[70, -59; 70, -52; 70,
         -45; 69, -45], style(fillColor=8, fillPattern=1));
  connect(Cylinder.frame_b, Piston.frame_b) annotation (points=[90, 79; 90,
        63.975; 90, 48.95; 90.5, 48.95], style(color=0, thickness=2));
  connect(cylPosition.frame_b, Cylinder.frame_a) annotation (points=[20.5, 110;
         90, 110; 90, 101], style(color=0, thickness=2));
  connect(world.frame_b, cylPosition.frame_a) annotation (points=[-29, -80; -20,
         -80; -20, 110; -1.5, 110], style(color=0, thickness=2));
  connect(Crank3.frame_b, Crank4.frame_a)
    annotation (points=[104.5, -60; 115.5, -60], style(color=0, thickness=2));
  connect(B1.frame_a, Mid.frame_b) annotation (points=[79, -26; 70, -26; 70, -38;
         98, -38; 98, -45; 91, -45], style(color=0, thickness=2));
  connect(B1.frame_b, Rod.frame_b) annotation (points=[101, -26; 112, -26; 112,
         -15; 90, -15; 90, -12], style(color=0, thickness=2));
  connect(Rod.frame_a, B2.frame_b) annotation (points=[90, 10; 90, 15; 110, 15;
         110, 26; 101, 26], style(color=0, thickness=2));
  connect(B2.frame_a, Piston.frame_b) annotation (points=[79, 26; 70, 26; 70,
        40; 90.5, 40; 90.5, 48.95], style(color=0, thickness=2));
  connect(Inertia.flange_b, Bearing.axis) annotation (points=[-31, -110; 0, -110;
         0, -90], style(
      color=0,
      fillColor=7,
      fillPattern=1));
end Engine;
