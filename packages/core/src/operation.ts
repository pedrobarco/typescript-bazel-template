export abstract class Operation {
    protected sym = "noop";

    protected abstract exec(a: number, b: number): number;

    stringify(a: number, b: number) {
        const res = this.exec(a, b);
        return `${a} ${this.sym} ${b} = ${res}`;
    }
}
