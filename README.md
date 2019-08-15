# WebAssembly Xorshift

Use: [AssemblyScript](https://docs.assemblyscript.org/)

## Sample

### Load

```js
const xos = { seed: () => {}, nextInt: () => { return 0; }, next: () => { return 0; } };

function LoadWebAssembly( wasm, importObject = {} )
{
	return new Promise( ( resolve, reject ) =>
	{
		WebAssembly.instantiateStreaming( wasm, importObject )
			.then( resolve ).catch( reject );
	} );
}

LoadWebAssembly( fetch( './xos.wasm' ), {} ).then( ( mod ) =>
{
	console.log( mod );
	// mod.instance.exports: { seed( a: number = 0, b: number = 0, c: number = 0, d: number = 0 ): void, nextInt(): number, next(): number, X: 123456789, Y: 362436069, Z: 521288629, W: 88675123 }
	xos.seed = mod.instance.exports.seed;
	xos.nextInt = mod.instance.exports.nextInt;
	xos.next = mod.instance.exports.next;
} ).catch( ( error ) => { console.log( error ); } );
```

### Load only

```js
const xos = { seed: () => {}, nextInt: () => { return 0; }, next: () => { return 0; } };

WebAssembly.instantiateStreaming( fetch( './xos.wasm' ), {} ).then( ( mod ) =>
{
	// mod.instance.exports: { seed( a: number = 0, b: number = 0, c: number = 0, d: number = 0 ): void, nextInt(): number, next(): number, X: 123456789, Y: 362436069, Z: 521288629, W: 88675123 }
	xos.seed = mod.instance.exports.seed;
	xos.nextInt = mod.instance.exports.nextInt;
	xos.next = mod.instance.exports.next;
} );
```

## JS Xorshift

C++、Webassmeblyと同じ実行結果になるXorshiftの実装。

```js
class Xorshift
{
	constructor( x = 0, y = 0, z = 0, w = 0 )
	{
		this.seed( x, y, z, w );
	}

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
		const t = ( this.x ^ ( this.x << 11 ) ) >>> 0;
		this.x = this.y;
		this.y = this.z;
		this.z = this.w;
		this.w = ( this.w ^ ( ( this.w >>> 19 ) >>> 0 ) ^ ( ( t ^ ( ( t >>> 8 ) >>> 0 ) ) >>> 0 ) ) >>> 0;
		return this.w;
	}

	next()
	{
		return this.nextInt() / 0xffffffff;
	}
}
```

### Usage

```js
const xos = ( ( Xorshift, wasm ) =>
{
	const rand = {};
	const xos = new Xorshift();
	rand.seed = ( x, y, z, w ) => { xos.seed( x, y, z, w ); };
	rand.nextInt = () => { return xos.nextInt(); };
	rand.next = () => { return xos.next(); };

	WebAssembly.instantiateStreaming( wasm, {} ).then( ( mod ) =>
	{
		rand.seed = mod.instance.exports.seed;
		rand.seed( xos.x, xos.y, xos.z, xos.w );
		rand.nextInt = mod.instance.exports.nextInt;
		rand.next = mod.instance.exports.next;
	} );

	return rand;
} )( class
{
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
		const t = ( this.x ^ ( this.x << 11 ) ) >>> 0;
		this.x = this.y;
		this.y = this.z;
		this.z = this.w;
		this.w = ( this.w ^ ( ( this.w >>> 19 ) >>> 0 ) ^ ( ( t ^ ( ( t >>> 8 ) >>> 0 ) ) >>> 0 ) ) >>> 0;
		return this.w;
	}

	next() { return this.nextInt() / 0xffffffff; }
}, './xos.wasm' );
```

## Other

### 補足

```js
WebAssembly.instantiateStreaming( fetch( './xos.wasm' ), {} ).then( ( mod ) =>
{
	console.log( mod ); // consoloe is not defined
} )
```

`WebAssembly.instantiateStreaming` や `WebAssembly.instantiate` の先の `then` 内では `console.log` 等が使えない。他にも制約がありそう。

上にあるサンプルのようにPromiseをかませれば特に問題なく使える。
