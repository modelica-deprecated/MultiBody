package Sensors "Sensors to measure variables"
  extends Modelica.Icons.Library;

  model RelativeSensor "Measure relative quantities between two frames"

    import SI = Modelica.SIunits;
    extends MultiBody.Interfaces.PartialRelativeSensor(outPort(n=3*((if
            get_r_rel then 1 else 0) + (if get_v_rel then 1 else 0) + (if
            get_a_rel then 1 else 0) + (if get_w_rel then 1 else 0) + (if
            get_z_rel then 1 else 0))));
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow)";
    parameter Boolean resolveInFrame_a=true
      "= true, if vectors are resolved in frame_a, otherwise in frame_b";
    parameter Boolean get_r_rel=true
      "= true, to measure position vector from origin of frame_a to origin of frame_b";
    parameter Boolean get_v_rel=false
      "= true, to measure velocity of origin of frame_b with respect to origin of frame_a";
    parameter Boolean get_a_rel=false
      "= true, to measure acceleration of origin of frame_b with respect to origin of frame_a";
    parameter Boolean get_w_rel=false
      "= true, to measure angular velocity of frame_b with respect to frame_a";
    parameter Boolean get_z_rel=false
      "= true, to measure angular acceleration of frame_b with respect to frame_a";
    parameter SI.Diameter arrowDiameter=world.defaultArrowDiameter
      "|Animation|if animation = true| Diameter of arrow from frame_a to frame_b";
    parameter MultiBody.Types.Color arrowColor=MultiBody.Types.Defaults.
        SensorColor
      "|Animation|if animation = true| Color of arrow from frame_a to frame_b";

    SI.Position r_rel[3]
      "Position vector from origin of frame_a to origin of frame_b resolved according to resolveInFrame_a";
    SI.Velocity v_rel[3]
      "Velocity of origin of frame_b with respect to origin of frame_a resolved according to resolveInFrame_a";
    SI.Acceleration a_rel[3]
      "Acceleration of origin of frame_b with respect to origin of frame_a resolved according to resolveInFrame_a";
    SI.AngularVelocity w_rel[3]
      "Angular velocity of frame_b with respect to frame_a resolved according to resolveInFrame_a";
    SI.AngularAcceleration z_rel[3]
      "Angular acceleration of frame_b with respect to frame_a resolved according to resolveInFrame_a";
    MultiBody.Frames.Orientation R_rel
      "Relative orientation of frame_b with respect to frame_a";
  protected
    parameter Integer i1=1;
    parameter Integer i2=if get_r_rel then i1 + 3 else i1;
    parameter Integer i3=if get_v_rel then i2 + 3 else i2;
    parameter Integer i4=if get_a_rel then i3 + 3 else i3;
    parameter Integer i5=if get_w_rel then i4 + 3 else i4;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    MultiBody.Visualizers.Advanced.Arrow arrow[ndim](
      each r=frame_a.r_0,
      each r_head=frame_b.r_0 - frame_a.r_0,
      each diameter=arrowDiameter,
      each color=arrowColor);
    annotation (
      preferedView="info",
      Icon,
      Diagram,
      Documentation(info="<HTML>
<p>
Relative kinematic quantities between frame_a and frame_b are
computed and provided at the output signal connector <b>outPort</b>
in packed format in the order
</p>
<ol>
<li> relative position vector (= r_rel)</li>
<li> relative velocity vectory (= v_rel = <b>der</b>(r_rel))</li>
<li> relative acceleration vector (<b>der</b>(v_rel))</li>
<li> relative angular velocity vector (= w_rel)</li>
<li> relative angular acceleration vector (= <b>der</b>(w_rel))</li>
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
If parameter <b>resolveInFrame_a</b> is <b>true</b>, then the
computed relative kinematic vectors are resolved in frame_a of this
component. Otherwise, the relative kinematic vectors are
resolved in frame_b. For example, if resolveInFrame_a = <b>false</b>, and
get_v_rel = <b>true</b>, then
<pre>
  outPort.signal = v_rel_b
                 = <b>der</b>(r_rel_b)
</pre>
is returned, i.e.,
the derivative of the relative distance r_rel_b from frame_a to frame_b,
resolved in frame_b.
</p>
</HTML>"));
  equation
    if get_r_rel or get_v_rel or get_a_rel then
      if resolveInFrame_a then
        r_rel = MultiBody.Frames.resolve2(frame_a.R, frame_b.r_0 - frame_a.r_0);
      else
        r_rel = MultiBody.Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);
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
        R_rel = MultiBody.Frames.relativeRotation(frame_b.R, frame_a.R);
        w_rel = -MultiBody.Frames.angularVelocity2(R_rel, der(R_rel));
      else
        R_rel = MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
        w_rel = MultiBody.Frames.angularVelocity2(R_rel, der(R_rel));
      end if;
    else
      R_rel = MultiBody.Frames.nullRotation();
      w_rel = zeros(3);
    end if;

    if get_z_rel then
      z_rel = der(w_rel);
    else
      z_rel = zeros(3);
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

    if get_w_rel then
      outPort.signal[i4:i4 + 2] = w_rel;
    end if;

    if get_z_rel then
      outPort.signal[i5:i5 + 2] = z_rel;
    end if;
  end RelativeSensor;

  model Power "Measure power flowing from frame_a to frame_b"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.RotationalSensor;
    Modelica.Blocks.Interfaces.OutPort outPort(final n=1, redeclare type
        SignalType = SI.Power)
      annotation (extent=[-90, -100; -70, -120], rotation=90);

    annotation (Diagram(
        Text(extent=[-44, -80; 28, -106], string="Power P"),
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, 0; -80, -100])), Icon(
        Line(points=[-70, 0; -101, 0], style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=0)),
        Line(points=[-80, 0; -80, -100]),
        Text(
          extent=[-68, -80; -16, -114],
          string="P",
          style(color=0)),
        Text(extent=[-128, 126; 126, 68], string="%name")));
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
  equation
    frame_a.r_0 = frame_b.r_0;
    frame_a.R = frame_b.R;
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t;
    outPort.signal[1] = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0))
       + frame_a.t*Frames.angularVelocity2(frame_a.R, der(frame_a.R));
  end Power;
end Sensors;
