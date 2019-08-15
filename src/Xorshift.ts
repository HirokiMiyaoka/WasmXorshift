class Xorshift
{
	public x: number;
	public y: number;
	public z: number;
	public w: number;

	constructor( x = 0, y = 0, z = 0, w = 0 ) { this.seed( x, y, z, w ); }

	seed( x = 0, y = 0, z = 0, w = 0 )
	{
		if ( !x && !y && !z && !w )
		{
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

	nextInt()
	{
		function n( n: number ) { return n < 0 ? n >>> 0 : n; }
		const t = n( this.x ^ ( this.x << 11 ) );
		this.x = this.y;
		this.y = this.z;
		this.z = this.w;
		this.w = n( this.w ^ n( this.w >>> 19 ) ^ n( t ^ n( t >>> 8 ) ) );
		return this.w;
	}

	next() { return this.nextInt() / 0xffffffff; }
}
