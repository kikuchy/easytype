package etp;

using Lambda;
// import JISKeyboardMetrics;

class EasyTypePassword {
    static var S_ALPHABET = [
        JISKeyboardMetrics.S_A,
        JISKeyboardMetrics.S_B,
        JISKeyboardMetrics.S_C,
        JISKeyboardMetrics.S_D,
        JISKeyboardMetrics.S_E,
        JISKeyboardMetrics.S_F,
        JISKeyboardMetrics.S_G,
        JISKeyboardMetrics.S_H,
        JISKeyboardMetrics.S_I,
        JISKeyboardMetrics.S_J,
        JISKeyboardMetrics.S_K,
        JISKeyboardMetrics.S_L,
        JISKeyboardMetrics.S_M,
        JISKeyboardMetrics.S_N,
        JISKeyboardMetrics.S_O,
        JISKeyboardMetrics.S_P,
        JISKeyboardMetrics.S_Q,
        JISKeyboardMetrics.S_R,
        JISKeyboardMetrics.S_S,
        JISKeyboardMetrics.S_T,
        JISKeyboardMetrics.S_U,
        JISKeyboardMetrics.S_V,
        JISKeyboardMetrics.S_W,
        JISKeyboardMetrics.S_X,
        JISKeyboardMetrics.S_Y,
        JISKeyboardMetrics.S_Z
    ];
    static var NUMBER = [
        JISKeyboardMetrics.N_1,
        JISKeyboardMetrics.N_2,
        JISKeyboardMetrics.N_3,
        JISKeyboardMetrics.N_4,
        JISKeyboardMetrics.N_5,
        JISKeyboardMetrics.N_6,
        JISKeyboardMetrics.N_7,
        JISKeyboardMetrics.N_8,
        JISKeyboardMetrics.N_9,
        JISKeyboardMetrics.N_0
    ];
    var usableSymbolArray: Array<KeyCoordinate>;
    var length: Int;

    public function new (usableSymbol : UsableSymbolType, length: Int) {
        this.length = length;
        this.usableSymbolArray = switch (usableSymbol) {
            case S_L_ALPHABET:
                S_ALPHABET;
            case S_L_ALPHABET_NUMBER:
                S_ALPHABET.concat(NUMBER);
            default:
                throw ("not implemented");
        }
    }

    public function generate () {
        var result = [];
        var initialSymbol = selectInitialSymbol();
        result.push(initialSymbol);

        var prevSymbol = initialSymbol;
        for (i in 1...this.length) {
            var nextSybmol = selectNextSymbol(prevSymbol);
            result.push(nextSybmol);
            prevSymbol = nextSybmol;
        }
        return result.map(function (c) { return c.glyph; }).join("");
    }

    private function selectInitialSymbol (){
        var allCount = this.usableSymbolArray.length;
        var idx = Math.floor(Math.random() * allCount);
        return this.usableSymbolArray[idx];
    }

    private function selectNextSymbol (prevSymbol: KeyCoordinate) {
        var descSymbolArray = this.usableSymbolArray.copy();
        descSymbolArray.sort(function (a, b) {
            return Math.floor(prevSymbol.distanceFrom(b) - prevSymbol.distanceFrom(a));
        });
        var sumOfDistance = this.sumOfDistance(prevSymbol);
        var idx = Math.random() * sumOfDistance;
        var tmpSum = 0.0;
        for (a in descSymbolArray) {
            tmpSum += prevSymbol.distanceFrom(a);
            if (tmpSum > idx) return a;
        }
        return null;
    }

    private function sumOfDistance (symbol) {
        var result = 0.0;
        for (a in this.usableSymbolArray) {
            result += symbol.distanceFrom(a);
        }
        return result;
        // return this.usableSymbolArray.fold(function (a, tmpSum) {
        //     return tmpSum + symbol.distanceFrom(a);
        // }, 0);
    }

    public static function main () {
        trace((new EasyTypePassword(S_L_ALPHABET_NUMBER, 12)).generate());
    }
}
