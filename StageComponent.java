import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

abstract class StageComponent implements Serializable {//the base class for all components that exsist inside a stage
  static skiny_mann source;
  public float x, y, z, dx, dy, dz;
  public int ccolor, group=-1;
  public String type;
  void draw() {
  };
  void draw3D() {
  };
  boolean colide(float x, float y, boolean c) {
    return false;
  };//c= is colideing with click box
  boolean colide(float x, float y, float z, boolean c) {
    return false;
  };
  boolean colideDethPlane(float x, float Y) {
    return false;
  };
  abstract JSONObject save(boolean stage_3D);

  void setData(String data) {
  }
  void setData(int data) {
  }

  String getData() {
    return null;
  }
  int getDataI() {
    return -1;
  }
  abstract StageComponent copy();
  Group getGroup() {
    if (group==-1)
      return new Group();
    return source.level.groups.get(group);
  }
  void setGroup(int grp) {
    group=grp;
  }

  void worldInteractions(int data) {
  }
}
