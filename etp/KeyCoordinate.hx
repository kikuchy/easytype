package etp;

class KeyCoordinate {
    var x: Int;
    var y: Int;
    public var glyph: String;

    public function new (x, y, g) {
        this.x = x;
        this.y = y;
        this.glyph = g;
    }

    public function distanceFrom (a: KeyCoordinate) : Float {
        return Math.sqrt(Math.pow(this.x - a.x, 2.0) + Math.pow(this.y - a.y, 2.0));
    }

    public static function main () {
        var a = new KeyCoordinate(10, 10, "a");
        var b = new KeyCoordinate(20, 20, "b");
        trace(a.distanceFrom(b));
    }
}
