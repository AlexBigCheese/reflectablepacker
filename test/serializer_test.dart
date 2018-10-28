library rpack.test.serialize;

import 'package:test/test.dart';
import 'package:ReflectablePackager/reflectablepackager.dart';
import 'serializer_test.reflectable.dart';

@rpack
class Alotta {
  String what;
  num howMuch;
  Alotta(this.what, this.howMuch);
}

@rpack
enum Colors { RED, GREEN, BLUE }

@rpack
class Tree {
  var left;
  var right;
  Tree(this.left, this.right);
}

void main() {
  initializeReflectable();
  Alotta alotta;
  RPackSerializer rPackSerializer;
  Tree treeBeginner;
  Tree otherTree;
  setUp(() {
    alotta = Alotta("Damage!", 10.3);
    treeBeginner = Tree(Tree(1, 2), Tree("Oat", "Meal"));
    otherTree = Tree(
      [
        1,
        2,
        "oatmeal",
      ],
      {
        "Kirb": [
          "Pink guy",
          Alotta(
            "cute",
            40.24,
          ),
        ],
      },
    );
    rPackSerializer = RPackSerializer();
  });
  test("Basic test", () {
    Map serLotta = rPackSerializer.serialize(alotta);
    expect(serLotta["%Type this"], "Alotta");
    expect(serLotta["what"], "Damage!");
    expect(serLotta["howMuch"], 10.3);
  });
  test("Enum test", () {
    expect(rPackSerializer.serialize(Colors.RED), 0);
  });

  test("Tree test", () {
    Map serTree = rPackSerializer.serialize(treeBeginner);
    expect(serTree["left"]["left"], 1);
    expect(serTree["left"]["right"], 2);
    expect(serTree["right"]["left"], "Oat");
    expect(serTree["right"]["right"], "Meal");
  });

  test("Type Tree test",() {
    Map serKirb = rPackSerializer.serialize(otherTree);
    print(serKirb);
    expect(serKirb["left"],[1,2,"oatmeal"]);
    expect(serKirb["right"]["Kirb"][0],"Pink guy");
    expect(serKirb["right"]["Kirb"][1]["%Type this"],"Alotta");
  });
}
