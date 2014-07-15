package etp;

class MovingProbability {
    var metrics: IKeyMetrics;

    public function new (metrics: IKeyMetrics, usableKey: UsableKeyType) {
        this.metrics = metrics;
    }

    public function probabilityFromTo(a: KeyCoordinate, b: KeyCoordinate) {


