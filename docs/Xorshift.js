class Xorshift {
    constructor(x = 0, y = 0, z = 0, w = 0) { this.seed(x, y, z, w); }
    seed(x = 0, y = 0, z = 0, w = 0) {
        if (!x && !y && !z && !w) {
            x = 123456789;
            y = 362436069;
            z = 521288629;
            w = 88675123;
        }
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
    }
    nextInt() {
        const t = (this.x ^ (this.x << 11)) >>> 0;
        this.x = this.y;
        this.y = this.z;
        this.z = this.w;
        this.w = (this.w ^ ((this.w >>> 19) >>> 0) ^ ((t ^ ((t >>> 8) >>> 0)) >>> 0)) >>> 0;
        return this.w;
    }
    next() { return this.nextInt() / 0xffffffff; }
}
