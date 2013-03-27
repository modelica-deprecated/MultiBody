package Sensors "Sensors to measure variables"
  model AbsoluteSensor
    "Measure absolute kinematic quantities of a frame connector"
    import SI = Modelica.SIunits;
    import MultiBody.Frames;
    extends Interfaces.PartialAbsoluteSensor(outPort(n=3*((if get_r_abs then 1 else
                  0) + (if get_v_abs then 1 else 0) + (if get_a_abs then 1 else
                  0) + (if get_angles then 1 else 0) + (if get_w_abs then 1 else
                  0) + (if get_z_abs then 1 else 0))));
    Interfaces.Frame_resolve frame_resolve
      "If connected, the output signals are resolved in this frame"
      annotation( extent=[-15, 100; 16, 120], rotation=-90);
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=false
      "= true, if vectors are resolved in frame_a, otherwise in the world frame (if connector frame_resolve is connected, vectors are resolved in frame_resolve)";
    parameter Boolean get_r_abs=true
      "= true, to measure the position vector from the origin of the world frame to the origin of frame_a in [m]";
    parameter Boolean get_v_abs=false
      "= true, to measure the absolute velocity of the origin of frame_a in [m/s]";
    parameter Boolean get_a_abs=false
      "= true, to measure the absolute acceleration of the origin of frame_a in [m/s^2]";
    parameter Boolean get_angles=false
      "= true, to measure the 3 rotation angles to rotate the world frame into frame_a along the axes defined in 'sequence' below in [rad]";
    parameter Boolean get_w_abs=false
      "= true, to measure the absolute angular velocity of frame_a in [rad/s]";
    parameter Boolean get_z_abs=false
      "= true, to measure the absolute angular acceleration to frame_a in [rad/s^2]";
    parameter MultiBody.Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3})=  {1,2,3}
      "|if get_angles = true| Angles are returned to rotate world frame around axes sequence[1], sequence[2] and finally sequence[3] into frame_a"
      annotation( Evaluate=true);
    parameter SI.Angle guessAngle1=0
      "|if get_angles = true| Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum";
    parameter SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "|Animation|if animation = true| Diameter of arrow from world frame to frame_a";
    parameter MultiBody.Types.Color arrowColor=MultiBody.Types.Defaults.
        SensorColor
      "|Animation|if animation = true| Color of arrow from world frame to frame_a";
    annotation(
      preferedView="info",
      Icon(
        Text(
          extent=[19, 121; 150, 96],
          style(color=8),
          string="resolve"),
        Line(points=[-70, 0; -70, 80; 0, 80; 0, 100], style(color=6, thickness=
                2)),
        Text(
          extent=[-132, 52; -96, 27],
          style(color=10),
          string="a")),
      Diagram,
      Documentation(info="<HTML>
<p>
Absolute kinematic quantities of frame_a are
computed and provided at the output signal connector <b>outPort</b>
in packed format in the order
</p>
<ol>
<li> absolute position vector (= r_abs)</li>
<li> absolute velocity vectory (= v_abs)</li>
<li> absolute acceleration vector (= a_abs)</li>
<li> 3 angles to rotate the world frame into frame_a (= angles)</li>
<li> absolute angular velocity vector (= w_abs)</li>
<li> absolute angular acceleration vector (= z_abs)</li>
</ol>
<p>
For example, if parameters <b>get_v</b> and <b>get_w</b>
are <b>true</b> and all other get_XXX parameters are <b>false</b>, then
outPort.signal contains 6 elements:
</p>
<pre>
 outPort.signal[1:3] = absolute velocity
 outPort.signal[4:6] = absolute angular velocity
</pre>

<p>
In the following figure the animation of an AbsoluteSensor
component is shown. The light blue coordinate system is
frame_a and the yellow arrow is the animated sensor.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/AbsoluteSensor.png\">
</p>

<p>
If <b>frame_resolve</b> is connected to another frame, then the
provided absolute kinematic vectors are resolved in this frame.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the relative quantities are
resolved is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
provided kinematic vectors are resolved in frame_a of this
component. Otherwise, the kinematic vectors are resolved in
the world frame. For example, if frame_resolve is not
connected and if resolveInFrame_a = <b>false</b>, and
get_v = <b>true</b>, then
</p>
<pre>
  outPort.signal = <b>der</b>(frame_a.r) // resolved in world frame
</pre>
<p>
is returned, i.e., the derivative of the distance frame_a.r_0
from the origin of the world frame to the origin of frame_a,
resolved in the world frame.
</p>
<p>
Note, the cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>
<p>
If <b>get_angles</b> = <b>true</b>, the 3 angles to rotate the world
frame into frame_a along the axes defined by parameter <b>sequence</b>
are returned. For example, if sequence = {3,1,2} then the world frame is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_a.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
There are <b>two solutions</b> for \"angles[1]\" in this range.
Via parameter <b>guessAngle1</b> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The transformation matrix between the world frame and
frame_a may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that parameter <b>sequence</b> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<pre>
  sequence = <b>{1,2,3}</b>  // Cardan angle sequence
           = <b>{3,1,3}</b>  // Euler angle sequence
           = <b>{3,2,1}</b>  // Tait-Bryan angle sequence
</pre>
<p>
Exact definition of the returned quantities:
</p>
<ol>
<li>r_abs is vector frame_a.r_0, resolved according to table below.</li>
<li>v_abs is vector <b>der</b>(frame_a.r_0), resolved according to table below.</li>
<li>a_abs is vector <b>der</b>(<b>der</b>(frame_a.r_0)), resolved according to
            table below.</li>
<li>angles is a vector of 3 angles such that
    frame_a.R = Frames.axesRotations(sequence, angles).</li>
<li>w_abs is vector MultiBody.Frames.angularVelocity1(frame_a.R, <b>der</b>(frame_a.R)),
            resolved according to table below.</li>
<li>z_abs is vector <b>der</b>(w_abs) (= derivative of absolute angular
            velocity of frame_a with respect to the world frame,
            resolved according to table below).</li>
</ol>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>frame_resolved is</i></b></th>
      <th><b><i>resolveInFrame_a =</i></b></th>
      <th><b><i>vector is resolved in</i></b></th>
  </tr>
  <tr><td>connected</td>
      <td>true</td>
      <td><b>frame_resolve</b></td>
  </tr>
  <tr><td>connected</td>
      <td>false</td>
      <td><b>frame_resolve</b></td>
  </tr>
  <tr><td>not connected</td>
      <td>true</td>
      <td><b>frame_a</b></td>
  </tr>
  <tr><td>not connected</td>
      <td>false</td>
      <td><b>world frame</b></td>
  </tr>
</table><br>
</HTML>
"));

  protected
    SI.Position r_abs[3]
      "Dummy or position vector from origin of the world frame to origin of frame_a (resolved in frame_resolve, frame_a or world frame)";
    SI.Velocity v_abs[3]
      "Dummy or velocity of origin of frame_a with respect to origin of world frame (resolved in frame_resolve, frame_a or world frame)";
    SI.Acceleration a_abs[3]
      "Dummy or acceleration of origin of frame_a with respect to origin of word frame (resolved in frame_resolve, frame_a or world frame)";
    SI.Acceleration angles[3]
      "Dummy or angles to rotate world frame into frame_a via 'sequence'";
    SI.AngularVelocity w_abs[3]
      "Dummy or angular velocity of frame_a with respect to world frame (resolved in frame_resolve, frame_a or world frame)";
    SI.AngularAcceleration z_abs[3]
      "Dummy or angular acceleration of frame_a with respect to world frame (resolved in frame_resolve, frame_a or world frame)";

    SI.Velocity v_abs_0[3]
      "Dummy or absolute velocity of origin of frame_a resolved in world frame";
    SI.Velocity w_abs_0[3]
      "Dummy or absolute angular velocity of frame_a resolved in world frame";
    parameter Integer i1=1;
    parameter Integer i2=if get_r_abs then i1 + 3 else i1;
    parameter Integer i3=if get_v_abs then i2 + 3 else i2;
    parameter Integer i4=if get_a_abs then i3 + 3 else i3;
    parameter Integer i5=if get_angles then i4 + 3 else i4;
    parameter Integer i6=if get_w_abs then i5 + 3 else i5;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    MultiBody.Visualizers.Advanced.Arrow arrow[ndim](
      each r_head=frame_a.r_0,
      each diameter=arrowDiameter,
      each color=arrowColor);
  equation
    if get_angles then
      angles = Frames.axesRotationsAngles(frame_a.R, sequence, guessAngle1);
    else
      angles = zeros(3);
    end if;

    if cardinality(frame_resolve) == 1 then
      // frame_resolve is connected
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      if get_r_abs then
        r_abs = Frames.resolve2(frame_resolve.R, frame_a.r_0);
      else
        r_abs = zeros(3);
      end if;

      if get_v_abs or get_a_abs then
        v_abs_0 = der(frame_a.r_0);
        v_abs = Frames.resolve2(frame_resolve.R, v_abs_0);
      else
        v_abs_0 = zeros(3);
        v_abs = zeros(3);
      end if;

      if get_a_abs then
        a_abs = Frames.resolve2(frame_resolve.R, der(v_abs_0));
      else
        a_abs = zeros(3);
      end if;

      if get_w_abs or get_z_abs then
        w_abs_0 = MultiBody.Frames.angularVelocity1(frame_a.R);
        w_abs = Frames.resolve2(frame_resolve.R, w_abs_0);
      else
        w_abs_0 = zeros(3);
        w_abs = zeros(3);
      end if;

      if get_z_abs then
        z_abs = Frames.resolve2(frame_resolve.R, der(w_abs_0));
      else
        z_abs = zeros(3);
      end if;
    else
      // frame_resolve is NOT connected
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();

      if get_r_abs then
        if resolveInFrame_a then
          r_abs = MultiBody.Frames.resolve2(frame_a.R, frame_a.r_0);
        else
          r_abs = frame_a.r_0;
        end if;
      else
        r_abs = zeros(3);
      end if;

      if get_v_abs or get_a_abs then
        v_abs_0 = der(frame_a.r_0);
        if resolveInFrame_a then
          v_abs = MultiBody.Frames.resolve2(frame_a.R, v_abs_0);
        else
          v_abs = v_abs_0;
        end if;
      else
        v_abs_0 = zeros(3);
        v_abs = zeros(3);
      end if;

      if get_a_abs then
        if resolveInFrame_a then
          a_abs = MultiBody.Frames.resolve2(frame_a.R, der(v_abs_0));
        else
          a_abs = der(v_abs_0);
        end if;
      else
        a_abs = zeros(3);
      end if;

      w_abs_0 = zeros(3);
      if get_w_abs or get_z_abs then
        if resolveInFrame_a then
          w_abs = MultiBody.Frames.angularVelocity2(frame_a.R);
        else
          w_abs = MultiBody.Frames.angularVelocity1(frame_a.R);
        end if;
      else
        w_abs = zeros(3);
      end if;

      if get_z_abs then
        /* if w_abs and z_abs are resolved in the world frame, we have
            z_abs = der(w_abs)
         if w_abs and z_abs are resolved in frame_a, we have
            z_abs = R*der(transpose(R)*w_abs)
                  = R*(der(transpose(R))*w_abs + transpose(R)*der(w_abs)))
                  = R*(transpose(R)*R*der(transpose(R))*w_abs + transpose(R)*der(w_abs)))
                  = skew(w_abs)*w_abs + der(w_abs)
                  = der(w_abs)  // since cross(w_abs, w_abs) = 0
      */
        z_abs = der(w_abs);
      else
        z_abs = zeros(3);
      end if;
    end if;

    frame_a.f = zeros(3);
    frame_a.t = zeros(3);

    if get_r_abs then
      outPort.signal[i1:i1 + 2] = r_abs;
    end if;

    if get_v_abs then
      outPort.signal[i2:i2 + 2] = v_abs;
    end if;

    if get_a_abs then
      outPort.signal[i3:i3 + 2] = a_abs;
    end if;

    if get_angles then
      outPort.signal[i4:i4 + 2] = angles;
    end if;

    if get_w_abs then
      outPort.signal[i5:i5 + 2] = w_abs;
    end if;

    if get_z_abs then
      outPort.signal[i6:i6 + 2] = z_abs;
    end if;
  end AbsoluteSensor;
  extends Modelica.Icons.Library;

  model RelativeSensor
    "Measure relative kinematic quantities between two frame connectors"

    import SI = Modelica.SIunits;
    import MultiBody.Frames;

    extends MultiBody.Interfaces.PartialRelativeSensor(outPort(n=3*((if
            get_r_rel then 1 else 0) + (if get_v_rel then 1 else 0) + (if
            get_a_rel then 1 else 0) + (if get_angles then 1 else 0) + (if
            get_w_rel then 1 else 0) + (if get_z_rel then 1 else 0))));
    Interfaces.Frame_resolve frame_resolve
      "If connected, the output signals are resolved in this frame"
      annotation( extent=[-95, -110; -64, -90], rotation=-90);

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=true
      "= true, if relative vectors from frame_a to frame_b are resolved before differentiation in frame_a, otherwise in frame_b. If frame_resolve is connected, the vector and its derivatives are resolved in frame_resolve";
    parameter Boolean get_r_rel=true
      "= true, to measure the relative position vector from the origin of frame_a to the origin of frame_b in [m]";
    parameter Boolean get_v_rel=false
      "= true, to measure the relative velocity of the origin of frame_b with respect to frame_a in [m/s]";
    parameter Boolean get_a_rel=false
      "= true, to measure the relative acceleration of the origin of frame_b with respect to frame_a in [m/s^2]";
    parameter Boolean get_angles=false
      "= true, to measure the 3 rotation angles to rotate frame_a into frame_b along the axes defined in 'sequence' below in [rad]";
    parameter Boolean get_w_rel=false
      "= true, to measure the relative angular velocity of frame_b with respect to frame_a in [rad/s]";
    parameter Boolean get_z_rel=false
      "= true, to measure the relative angular acceleration of frame_b with respect to frame_a in [rad/s^2]";
    parameter MultiBody.Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3})=  {1,2,3}
      "|if get_angles = true| Angles are returned to rotate frame_a around axes sequence[1], sequence[2] and finally sequence[3] into frame_b"
      annotation( Evaluate=true);
    parameter SI.Angle guessAngle1=0
      "|if get_angles = true| Select angles[1] such that abs(angles[1] - guessAngle1) is a minimum";
    parameter SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "|Animation|if animation = true| Diameter of relative arrow from frame_a to frame_b";
    parameter MultiBody.Types.Color arrowColor=MultiBody.Types.Defaults.
        SensorColor
      "|Animation|if animation = true| Color of relative arrow from frame_a to frame_b";

    SI.Position r_rel[3]
      "Dummy or relative position vector (resolved in frame_a, frame_b or frame_resolve)";
    SI.Velocity v_rel[3]
      "Dummy or relative velocity vector (resolved in frame_a, frame_b or frame_resolve";
    SI.Acceleration a_rel[3]
      "Dummy or relative acceleration vector (resolved in frame_a, frame_b or frame_resolve";
    SI.Acceleration angles[3]
      "Dummy or angles to rotate frame_a into frame_b via 'sequence'";
    SI.AngularVelocity w_rel[3]
      "Dummy or relative angular velocity vector (resolved in frame_a, frame_b or frame_resolve";
    SI.AngularAcceleration z_rel[3]
      "Dummy or relative angular acceleration vector (resolved in frame_a, frame_b or frame_resolve";
    Frames.Orientation R_rel
      "Dummy or relative orientation object from frame_a to frame_b";
  protected
    SI.Position r_rel_ab[3]
      "Dummy or relative position vector resolved in frame_a or frame_b";
    SI.Velocity der_r_rel_ab[3]
      "Dummy or derivative of relative position vector (resolved in frame_a, frame_b or frame_resolve)";
    SI.AngularVelocity w_rel_ab[3]
      "Dummy or angular velocity of frame_b with respect to frame_a (resolved in frame_a or frame_b)";
    Frames.Orientation R_resolve
      "Dummy or relative orientation of frame_a or frame_b with respect to frame_resolve";

    parameter Integer i1=1;
    parameter Integer i2=if get_r_rel then i1 + 3 else i1;
    parameter Integer i3=if get_v_rel then i2 + 3 else i2;
    parameter Integer i4=if get_a_rel then i3 + 3 else i3;
    parameter Integer i5=if get_angles then i4 + 3 else i4;
    parameter Integer i6=if get_w_rel then i5 + 3 else i5;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    MultiBody.Visualizers.Advanced.Arrow arrow[ndim](
      each r=frame_a.r_0,
      each r_head=frame_b.r_0 - frame_a.r_0,
      each diameter=arrowDiameter,
      each color=arrowColor);
    annotation(
      preferedView="info",
      Icon(Line(points=[-80, -102; -80, -90; 0, -90; 0, -90], style(color=6,
              thickness=2)), Text(
          extent=[-135, -61; -4, -86],
          style(color=8),
          string="resolve")),
      Diagram,
      Documentation(info="<HTML>
<p>
Relative kinematic quantities between frame_a and frame_b are
determined and provided at the output signal connector <b>outPort</b>
in packed format in the order
</p>
<ol>
<li> relative position vector (= r_rel)</li>
<li> relative velocity vectory (= v_rel)</li>
<li> relative acceleration vector (= a_rel))</li>
<li> 3 angles to rotate frame_a into frame_b (= angles)</li>
<li> relative angular velocity vector (= w_rel)</li>
<li> relative angular acceleration vector (= z_rel)</li>
</ol>
<p>
For example, if parameters <b>get_v_rel</b> and <b>get_w_rel</b>
are <b>true</b> and all other get_XXX parameters are <b>false</b>, then
outPort.signal contains 6 elements:
</p>
<pre>
 outPort.signal[1:3] = relative velocity
 outPort.signal[4:6] = relative angular velocity
</pre>
<p>
In the following figure the animation of a RelativeSensor
component is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/RelativeSensor.png\">
</p>

<p>
If parameter <b>resolveInFrame_a</b> = <b>true</b>, then the
provided relative kinematic vectors of frame_b with respect to
frame_a are resolved before differentiation in frame_a. If this
parameter is <b>false</b>, the relative kinematic vectors are
resolved before differentiation in frame_b.
If <b>frame_resolve</b> is connected to another frame, then the
kinematic vector as defined above and/or its required derivatives
are resolved in frame_resolve. Note, derivatives
of relative kinematic quantities are always performed with
respect to frame_a (<b>resolveInFrame_a</b> = <b>true</b>)
or with respect to frame_b (<b>resolveInFrame_a</b> = <b>false</b>).
The resulting vector is then resolved in frame_resolve, if this
connector is connected.
</p>
<p>
For example, if frame_resolve is not
connected and if resolveInFrame_a = <b>false</b>, and
get_v = <b>true</b>, then
</p>
<pre>
  outPort.signal = v_rel
                 = <b>der</b>(r_rel)
</pre>
is returned (r_rel = resolve2(frame_b.R, frame_b.r_0 - frame_a.r0)), i.e.,
the derivative of the relative distance from frame_a to frame_b,
resolved in frame_b. If frame_resolve is connected, then
</p>
<pre>
  outPort.signal = v_rel
                 = resolve2(frame_resolve.R, <b>der</b>(r_rel))
</pre>
<p>
is returned, i.e., the previous relative velocity vector is
additionally resolved in frame_resolve.
</p>
<p>
Note, the cut-force and the cut-torque in frame_resolve are
always zero, whether frame_resolve is connected or not.
</p>
<p>
If <b>get_angles</b> = <b>true</b>, the 3 angles to rotate frame_a
into frame_b along the axes defined by parameter <b>sequence</b>
are returned. For example, if sequence = {3,1,2} then frame_a is
rotated around angles[1] along the z-axis, afterwards it is rotated
around angles[2] along the x-axis, and finally it is rotated around
angles[3] along the y-axis and is then identical to frame_b.
The 3 angles are returned in the range
</p>
<pre>
    -<font face=\"Symbol\">p</font> &lt;= angles[i] &lt;= <font face=\"Symbol\">p</font>
</pre>
<p>
There are <b>two solutions</b> for \"angles[1]\" in this range.
Via parameter <b>guessAngle1</b> (default = 0) the
returned solution is selected such that |angles[1] - guessAngle1| is
minimal. The relative transformation matrix between frame_a and
frame_b may be in a singular configuration with respect to \"sequence\", i.e.,
there is an infinite number of angle values leading to the same relative
transformation matrix. In this case, the returned solution is
selected by setting angles[1] = guessAngle1. Then angles[2]
and angles[3] can be uniquely determined in the above range.
</p>
<p>
Note, that parameter <b>sequence</b> has the restriction that
only values 1,2,3 can be used and that sequence[1] &ne; sequence[2]
and sequence[2] &ne; sequence[3]. Often used values are:
</p>
<pre>
  sequence = <b>{1,2,3}</b>  // Cardan angle sequence
           = <b>{3,1,3}</b>  // Euler angle sequence
           = <b>{3,2,1}</b>  // Tait-Bryan angle sequence
</pre>
<p>
Exact definition of the returned quantities
(r_rel_ab, R_rel_ab, w_rel_ab are defined below the enumeration):
</p>
<ol>
<li>r_rel is vector r_rel_ab, resolved according to table below.</li>
<li>v_rel is vector <b>der</b>(r_rel_ab), resolved according to table below.</li>
<li>a_rel is vector <b>der</b>(<b>der</b>(r_rel_ab)), resolved according to
            table below.</li>
<li>angles is a vector of 3 angles such that
    R_rel_ab = Frames.axesRotations(sequence, angles).</li>
<li>w_rel is vector w_rel_ab, resolved according to table below.</li>
<li>z_rel is vector <b>der</b>(w_rel_ab), resolved according to table below.</li>
</ol>
<p>
using the auxiliary quantities
</p>
<ol>
<li> r_rel_ab is vector frame_b.r_0 - frame_a.r_0, resolved either in frame_a or
     frame_b according to parameter resolveInFrame_a.</li>
<li> R_rel_ab is orientation object Frames.relativeRotation(frame_a.R, frame_b.R).</li>
<li> w_rel_ab is vector Frames.angularVelocity1(R_rel_ab, der(R_rel_ab)), resolved either
     in frame_a or frame_b according to parameter resolveInFrame_a.</li>
</ol>
<p>
and resolved in the following frame
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>frame_resolved is</i></b></th>
      <th><b><i>resolveInFrame_a =</i></b></th>
      <th><b><i>vector is resolved in</i></b></th>
  </tr>
  <tr><td>connected</td>
      <td>true</td>
      <td><b>frame_resolve</b></td>
  </tr>
  <tr><td>connected</td>
      <td>false</td>
      <td><b>frame_resolve</b></td>
  </tr>
  <tr><td>not connected</td>
      <td>true</td>
      <td><b>frame_a</b></td>
  </tr>
  <tr><td>not connected</td>
      <td>false</td>
      <td><b>frame_b</b></td>
  </tr>
</table><br>
</HTML>"));
  equation
    if get_angles or get_w_rel or get_z_rel then
      R_rel = MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
    else
      R_rel = MultiBody.Frames.nullRotation();
    end if;

    if get_angles then
      angles = Frames.axesRotationsAngles(R_rel, sequence, guessAngle1);
    else
      angles = zeros(3);
    end if;

    if cardinality(frame_resolve) == 1 then
      // frame_resolve is connected
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      if resolveInFrame_a then
        R_resolve = Frames.relativeRotation(frame_a.R, frame_resolve.R);
      else
        R_resolve = Frames.relativeRotation(frame_b.R, frame_resolve.R);
      end if;

      if get_r_rel or get_v_rel or get_a_rel then
        if resolveInFrame_a then
          r_rel_ab = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
        else
          r_rel_ab = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
        end if;
        r_rel = Frames.resolve2(R_resolve, r_rel_ab);
      else
        r_rel_ab = zeros(3);
        r_rel = zeros(3);
      end if;

      if get_v_rel or get_a_rel then
        der_r_rel_ab = der(r_rel_ab);
      else
        der_r_rel_ab = zeros(3);
      end if;

      if get_v_rel then
        v_rel = Frames.resolve2(R_resolve, der_r_rel_ab);
      else
        v_rel = zeros(3);
      end if;

      if get_a_rel then
        a_rel = Frames.resolve2(R_resolve, der(der_r_rel_ab));
      else
        a_rel = zeros(3);
      end if;

      if get_w_rel or get_z_rel then
        if resolveInFrame_a then
          w_rel_ab = MultiBody.Frames.angularVelocity1(R_rel);
        else
          w_rel_ab = MultiBody.Frames.angularVelocity2(R_rel);
        end if;
        w_rel = Frames.resolve2(R_resolve, w_rel_ab);
      else
        w_rel = zeros(3);
        w_rel_ab = zeros(3);
      end if;

      if get_z_rel then
        z_rel = Frames.resolve2(R_resolve, der(w_rel_ab));
      else
        z_rel = zeros(3);
      end if;

    else
      // frame_resolve is NOT connected
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
      R_resolve = Frames.nullRotation();
      r_rel_ab = zeros(3);
      der_r_rel_ab = zeros(3);
      w_rel_ab = zeros(3);

      if get_r_rel or get_v_rel or get_a_rel then
        if resolveInFrame_a then
          r_rel = Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
        else
          r_rel = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
        end if;
      else
        r_rel = zeros(3);
      end if;

      if get_v_rel or get_a_rel then
        v_rel = der(r_rel);
      else
        v_rel = zeros(3);
      end if;

      if get_a_rel then
        a_rel = der(v_rel);
      else
        a_rel = zeros(3);
      end if;

      if get_w_rel or get_z_rel then
        if resolveInFrame_a then
          w_rel = Frames.angularVelocity1(R_rel);
        else
          w_rel = Frames.angularVelocity2(R_rel);
        end if;
      else
        w_rel = zeros(3);
      end if;

      if get_z_rel then
        z_rel = der(w_rel);
      else
        z_rel = zeros(3);
      end if;
    end if;

    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.f = zeros(3);
    frame_b.t = zeros(3);

    if get_r_rel then
      outPort.signal[i1:i1 + 2] = r_rel;
    end if;

    if get_v_rel then
      outPort.signal[i2:i2 + 2] = v_rel;
    end if;

    if get_a_rel then
      outPort.signal[i3:i3 + 2] = a_rel;
    end if;

    if get_angles then
      outPort.signal[i4:i4 + 2] = angles;
    end if;

    if get_w_rel then
      outPort.signal[i5:i5 + 2] = w_rel;
    end if;

    if get_z_rel then
      outPort.signal[i6:i6 + 2] = z_rel;
    end if;
  end RelativeSensor;

  model Distance
    "Measure the distance between the origins of two frame connectors"

    import SI = Modelica.SIunits;
    import MultiBody.Frames;

    extends Modelica.Icons.TranslationalSensor;
    Interfaces.Frame_a frame_a annotation( extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation( extent=[100, -15; 120, 15]);
    Modelica.Blocks.Interfaces.OutPort outPort
      annotation( extent=[-10, -100; 10, -120], rotation=90);

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=true;
    parameter SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "|Animation|if animation = true| Diameter of relative arrow from frame_a to frame_b";
    parameter MultiBody.Types.Color arrowColor=MultiBody.Types.Defaults.
        SensorColor
      "|Animation|if animation = true| Color of relative arrow from frame_a to frame_b";
    parameter SI.Position s_small=1.E-10
      "|Advanced|| Prevent zero-division if distance between frame_a and frame_b is zero";
    SI.Distance distance
      "Distance between the origin of frame_a and the origin of frame_b (distance >= s_small)";
  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    MultiBody.Visualizers.Advanced.Arrow arrow[ndim](
      each r=frame_a.r_0,
      each r_head=frame_b.r_0 - frame_a.r_0,
      each diameter=arrowDiameter,
      each color=arrowColor);
    annotation(
      preferedView="info",
      Icon(
        Line(points=[0, -60; 0, -100]),
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Text(
          extent=[-136, 44; -100, 19],
          style(color=10),
          string="a"),
        Text(
          extent=[101, 41; 137, 16],
          style(color=10),
          string="b"),
        Text(
          extent=[1, -80; 144, -104],
          style(color=8),
          string="distance")),
      Diagram(
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[0, -60; 0, -100]),
        Text(extent=[-22, 70; 20, 46], string="distance"),
        Line(points=[-98, 40; 88, 40]),
        Polygon(points=[102, 40; 87, 46; 87, 34; 102, 40], style(
            color=3,
            fillColor=3,
            fillPattern=1))),
      Documentation(info="<HTML>
<p>
The <b>distance</b> between the origins of frame_a
and of frame_b are determined and provided at the
output signal connector <b>outPort</b>. This
distance is always positive. <b>Derivatives</b> of this
signal can be easily obtained by connecting the
block
<a href=\"Modelica:Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>
to the outPort
connector (this block performs analytic differentiation
of the input signal using the der(..) operator).
</p>
<p>
In the following figure the animation of a Distance
sensor is shown. The light blue coordinate system is
frame_a, the dark blue coordinate system is frame_b, and
the yellow arrow is the animated sensor.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/Distance.png\">
</p>
</HTML>"));
  protected
    SI.Position r_rel_0[3]
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Length trueDistance
      "True distance between the origin of frame_a and the origin of frame_b";
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of LineSensor object is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of LineSensor object is not connected");
    assert(noEvent(trueDistance > s_small), "
The distance between the origin of frame_a and the origin of frame_b
of a LineSensor component became smaller as parameter s_small
(= a small number, defined in the \"Advanced\" menu). The distance is
set to s_small, although it is smaller. The reason is that the
time derivative of the distance becomes infinity for distance = 0.
This situation leads usually to numerical problems, e.g.,
a division by zero may occur.
");
    frame_a.f = zeros(3);
    frame_b.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.t = zeros(3);

    r_rel_0 = frame_b.r_0 - frame_a.r_0;
    trueDistance = Frames.length(r_rel_0);
    distance = Frames.Internal.maxWithoutEvent(trueDistance, s_small);
    outPort.signal[1] = distance;
  end Distance;

  model CutForce "Measure cut force vector"

    import SI = Modelica.SIunits;

    extends MultiBody.Interfaces.PartialCutForceSensor(outPort(redeclare type
          SignalType = SI.Force));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true
      "= true, if force with positive sign is returned (= frame_a.f), otherwise with negative sign (= frame_b.f)";
    parameter Boolean resolveInFrame_a=true
      "= true, if force is resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the force is resolved in frame_resolve)";
    parameter Real N_to_m(unit="N/m")=  1000
      "|if animation = true| Force arrow scaling (length = force/N_to_m)";
    parameter SI.Diameter forceDiameter=world.defaultArrowDiameter
      "|if animation = true| Diameter of force arrow";
    parameter MultiBody.Types.Color forceColor=MultiBody.Types.Defaults.
        ForceColor "|if animation = true| Color of force arrow";
    SI.Force force[3]
      "Cut force resolved in frame_a/frame_b or in frame_resolved, if connected";
    annotation(
      preferedView="info",
      Icon(Text(
          extent=[-162, -70; -46, -96],
          string="force",
          style(color=8))),
      Diagram,
      Documentation(info="<HTML>
<p>
The cut-force acting at the component to which frame_b is
connected is determined and provided at the output signal connector
<b>outPort</b> (= frame_a.f). If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force is provided (= frame_b.f).
If <b>frame_resolve</b> is connected to another frame, then the
cut-force is resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-force is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-force is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>

<p>
In the following figure the animation of a CutForce
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut force acting at frame_b and
with negative sign at frame_a.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/CutForce.png\">
</p>

</HTML>"));
  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    SI.Position f_in_m[3]=frame_a.f*(if positiveSign then +1 else -1)/N_to_m
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow forceArrow[ndim](
      each diameter=forceDiameter,
      each color=forceColor,
      each R=frame_b.R,
      each r=frame_b.r_0,
      each r_tail=f_in_m,
      each r_head=-f_in_m);
  equation
    if cardinality(frame_resolve) == 1 then
      force = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.f))*(if positiveSign then +1 else -1);
    elseif resolveInFrame_a then
      force = frame_a.f*(if positiveSign then +1 else -1);
    else
      force = Frames.resolve1(frame_a.R, frame_a.f)*(if positiveSign then +1 else
              -1);
    end if;

    outPort.signal = force;
  end CutForce;

  model CutTorque "Measure cut torque vector"

    import SI = Modelica.SIunits;

    extends MultiBody.Interfaces.PartialCutForceSensor(outPort(redeclare type
          SignalType = SI.Torque));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean positiveSign=true
      "= true, if torque with positive sign is returned (= frame_a.t), otherwise with negative sign (= frame_b.t)";
    parameter Boolean resolveInFrame_a=true
      "= true, if torque is resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the torque is resolved in frame_resolve)";
    parameter Real Nm_to_m(unit="N.m/m")=  1000
      "|if animation = true| Torque arrow scaling (length = torque/Nm_to_m)";
    parameter SI.Diameter torqueDiameter=world.defaultArrowDiameter
      "|if animation = true| Diameter of torque arrow";
    parameter MultiBody.Types.Color torqueColor=MultiBody.Types.Defaults.
        TorqueColor "|if animation = true| Color of torque arrow";
    SI.Torque torque[3]
      "Cut torque resolved in frame_a/frame_b or in frame_resolved, if connected";
    annotation(
      preferedView="info",
      Icon(Text(
          extent=[-168, -72; -52, -98],
          style(color=8),
          string="torque")),
      Diagram,
      Documentation(info="<HTML>
<p>
The cut-torque acting at the component to which frame_b is
connected is determined and provided at the output signal connector
<b>outPort</b> (= frame_a.t). If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force is provided (= frame_b.t).
If <b>frame_resolve</b> is connected to another frame, then the
cut-torque is resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-torque is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-torque is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>

<p>
In the following figure the animation of a CutTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrow is the cut torque acting at frame_b and
with negative sign at frame_a.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/CutTorque.png\">
</p>

</HTML>"));
  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    SI.Position t_in_m[3]=frame_a.t*(if positiveSign then +1 else -1)/Nm_to_m
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow torqueArrow[ndim](
      each diameter=torqueDiameter,
      each color=torqueColor,
      each R=frame_b.R,
      each r=frame_b.r_0,
      each r_tail=t_in_m,
      each r_head=-t_in_m);
  equation
    if cardinality(frame_resolve) == 1 then
      torque = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.t))*(if positiveSign then +1 else -1);
    elseif resolveInFrame_a then
      torque = frame_a.t*(if positiveSign then +1 else -1);
    else
      torque = Frames.resolve1(frame_a.R, frame_a.t)*(if positiveSign then +1 else
              -1);
    end if;

    outPort.signal = torque;
  end CutTorque;

  model CutForceAndTorque "Measure cut force and cut torque vector"

    import SI = Modelica.SIunits;

    extends MultiBody.Interfaces.PartialCutForceSensor(outPort(n=6));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show force and torque arrow)";
    parameter Boolean positiveSign=true
      "= true, if force and torque with positive sign is returned (= frame_a.f/.t), otherwise with negative sign (= frame_b.f/.t)";
    parameter Boolean resolveInFrame_a=true
      "= true, if force and torque are resolved in frame_a/frame_b, otherwise in the world frame (if connector frame_resolve is connected, the force/torque is resolved in frame_resolve)";
    parameter Real N_to_m(unit="N/m")=  1000
      "|if animation = true| Force arrow scaling (length = force/N_to_m)";
    parameter Real Nm_to_m(unit="N.m/m")=  1000
      "|if animation = true| Torque arrow scaling (length = torque/Nm_to_m)";
    parameter SI.Diameter forceDiameter=world.defaultArrowDiameter
      "|if animation = true| Diameter of force arrow";
    parameter SI.Diameter torqueDiameter=forceDiameter
      "|if animation = true| Diameter of torque arrow";
    parameter MultiBody.Types.Color forceColor=MultiBody.Types.Defaults.
        ForceColor "|if animation = true| Color of force arrow";
    parameter MultiBody.Types.Color torqueColor=MultiBody.Types.Defaults.
        TorqueColor "|if animation = true| Color of torque arrow";
    SI.Force force[3]
      "Cut force resolved in frame_a/frame_b or in frame_resolved, if connected";
    SI.Torque torque[3]
      "Cut torque resolved in frame_a/frame_b or in frame_resolved, if connected";
    annotation(
      preferedView="info",
      Icon,
      Diagram,
      Documentation(info="<HTML>
<p>
The cut-force and cut-torque acting at the component to which frame_b is
connected are determined and provided at the output signal connector
<b>outPort</b>:
</p>
<pre>
  outPort.signal[1:3] = frame_a.f;
  outPort.signal[4:6] = frame_a.t;
</pre>
<p>
If parameter <b>positiveSign</b> =
<b>false</b>, the negative cut-force and negative
cut-torque is provided (= frame_b.f and frame_b.t).
If <b>frame_resolve</b> is connected to another frame, then the
cut-force and cut-torque are resolved in frame_resolve.
If <b>frame_resolve</b> is <b>not</b> connected then the
coordinate system in which the cut-force and cut-torque is resolved
is defined by parameter <b>resolveInFrame_a</b>.
If this parameter is <b>true</b>, then the
cut-force and cut-torque is resolved in frame_a, otherwise it is
resolved in the world frame.
</p>
<p>
In the following figure the animation of a CutForceAndTorque
sensor is shown. The dark blue coordinate system is frame_b,
and the green arrows are the cut force and the cut torque,
respectively, acting at frame_b and
with negative sign at frame_a.
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Sensors/CutForceAndTorque.png\">
</p>
</HTML>"));
  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter Integer csign=if positiveSign then +1 else -1;
    SI.Position f_in_m[3]=frame_a.f*csign/N_to_m
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_a.t*csign/Nm_to_m
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow[ndim](
      each diameter=forceDiameter,
      each color=forceColor,
      each R=frame_b.R,
      each r=frame_b.r_0,
      each r_tail=f_in_m,
      each r_head=-f_in_m);
    Visualizers.Advanced.DoubleArrow torqueArrow[ndim](
      each diameter=torqueDiameter,
      each color=torqueColor,
      each R=frame_b.R,
      each r=frame_b.r_0,
      each r_tail=t_in_m,
      each r_head=-t_in_m);
  equation
    if cardinality(frame_resolve) == 1 then
      force = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.f))*csign;
      torque = Frames.resolve2(frame_resolve.R, Frames.resolve1(frame_a.R,
        frame_a.t))*csign;
    elseif resolveInFrame_a then
      force = frame_a.f*csign;
      torque = frame_a.t*csign;
    else
      force = Frames.resolve1(frame_a.R, frame_a.f)*csign;
      torque = Frames.resolve1(frame_a.R, frame_a.t)*csign;
    end if;

    outPort.signal[1:3] = force;
    outPort.signal[4:6] = torque;
  end CutForceAndTorque;

  model Power "Measure power flowing from frame_a to frame_b"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.OutPort outPort(final n=1, redeclare type
        SignalType = SI.Power)
      annotation( extent=[-90, -100; -70, -120], rotation=90);

    annotation(
      Diagram(
        Text(extent=[-44, -80; 28, -106], string="Power P"),
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, 0; -80, -100])),
      Icon(
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, 0; -80, -100]),
        Text(
          extent=[-68, -80; -16, -114],
          string="P",
          style(color=0)),
        Text(extent=[-128, 126; 126, 68], string="%name")),
      Documentation(info="<HTML>
<p>
This component provides the power flowing from frame_a to frame_b
as output signal (outPort.signal[1]).
</p>
</HTML>"));
    Interfaces.Frame_a frame_a annotation( extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation( extent=[100, -15; 120, 15]);
  equation
    defineBranch(frame_a.R, frame_b.R);
    frame_a.r_0 = frame_b.r_0;
    frame_a.R = frame_b.R;
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t;
    outPort.signal[1] = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0))
       + frame_a.t*Frames.angularVelocity2(frame_a.R);
  end Power;
  annotation( preferedView="info", Documentation(info="<HTML>
<p>
Package <b>Sensors</b> contains <b>ideal measurement</b>
components to determine absolute and relative kinematic
quantities, as well as cut-forces and cut-torques. All
measured quantities can be provided in every desired
coordinate system.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.AbsoluteSensor\">AbsoluteSensor</a></b></td>
      <td> Measure absolute kinematic quantities of a frame connector<br>
       <img src=\"../Images/Sensors/AbsoluteSensor.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.RelativeSensor\">RelativeSensor</a></b></td>
      <td> Measure relative kinematic quantities between two frame connectors<br>
       <img src=\"../Images/Sensors/RelativeSensor.png\"></td> </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.Distance\">Distance</a></b></td>
      <td> Measure distance between the origins of two frame connectors <br>
       <img src=\"../Images/Sensors/Distance.png\"></td></td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.CutForce\">CutForce</a></b></td>
      <td> Measure cut force vector <br>
       <img src=\"../Images/Sensors/CutForce.png\"></td></td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.CutTorque\">CutTorque</a></b></td>
      <td> Measure cut torque vector <br>
       <img src=\"../Images/Sensors/CutTorque.png\"></td></td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.CutForceAndTorque\">CutForceAndTorque</a></b></td>
      <td> Measure cut force and cut torque vector <br>
       <img src=\"../Images/Sensors/CutForceAndTorque.png\"></td></td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Sensors.Power\">Power</a></b></td>
      <td> Measure power flowing from frame_a to frame_b</td>
  </tr>
</table>
</HTML>"));
end Sensors;
