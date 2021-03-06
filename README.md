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
		WebAssembly.instantiateStreaming( wasm, importObject ).then( resolve ).catch( reject );
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

### Use binary

WebAssemblyのバイナリデータを直にソースコードに埋め込むことで、`fetch()` が使えないローカルでも利用することができる。

```js
function CompileXorshift()
{
	return WebAssembly.compile( Uint8Array.from( [
		0x00,0x61,0x73,0x6D,0x01,0x00,0x00,0x00,0x01,0x13,0x04,0x60,0x00,0x00,0x60,0x04,
		0x7F,0x7F,0x7F,0x7F,0x00,0x60,0x00,0x01,0x7C,0x60,0x01,0x7F,0x00,0x03,0x09,0x08,
		0x00,0x01,0x02,0x02,0x00,0x00,0x01,0x03,0x04,0x04,0x01,0x70,0x00,0x01,0x05,0x03,
		0x01,0x00,0x00,0x06,0x3C,0x09,0x7F,0x00,0x41,0x95,0x9A,0xEF,0x3A,0x0B,0x7F,0x00,
		0x41,0xE5,0xAB,0xE9,0xAC,0x01,0x0B,0x7F,0x00,0x41,0xB5,0xF7,0xC8,0xF8,0x01,0x0B,
		0x7F,0x00,0x41,0xB3,0xA6,0xA4,0x2A,0x0B,0x7F,0x01,0x41,0x00,0x0B,0x7F,0x01,0x41,
		0x00,0x0B,0x7F,0x01,0x41,0x00,0x0B,0x7F,0x01,0x41,0x00,0x0B,0x7F,0x01,0x41,0x00,
		0x0B,0x07,0x3E,0x09,0x06,0x6D,0x65,0x6D,0x6F,0x72,0x79,0x02,0x00,0x01,0x58,0x03,
		0x00,0x01,0x59,0x03,0x01,0x01,0x5A,0x03,0x02,0x01,0x57,0x03,0x03,0x09,0x5F,0x5F,
		0x73,0x65,0x74,0x61,0x72,0x67,0x63,0x00,0x07,0x04,0x73,0x65,0x65,0x64,0x00,0x06,
		0x07,0x6E,0x65,0x78,0x74,0x49,0x6E,0x74,0x00,0x02,0x04,0x6E,0x65,0x78,0x74,0x00,
		0x03,0x08,0x01,0x04,0x09,0x07,0x01,0x00,0x41,0x00,0x0B,0x01,0x05,0x0A,0xE1,0x01,
		0x08,0x12,0x00,0x23,0x00,0x24,0x04,0x23,0x01,0x24,0x05,0x23,0x02,0x24,0x06,0x23,
		0x03,0x24,0x07,0x0B,0x43,0x00,0x20,0x00,0x45,0x04,0x7F,0x20,0x01,0x45,0x05,0x41,
		0x00,0x0B,0x04,0x7F,0x20,0x02,0x45,0x05,0x41,0x00,0x0B,0x04,0x7F,0x20,0x03,0x45,
		0x05,0x41,0x00,0x0B,0x04,0x40,0x23,0x00,0x21,0x00,0x23,0x01,0x21,0x01,0x23,0x02,
		0x21,0x02,0x23,0x03,0x21,0x03,0x0B,0x20,0x00,0x24,0x04,0x20,0x01,0x24,0x05,0x20,
		0x02,0x24,0x06,0x20,0x03,0x24,0x07,0x0B,0x30,0x01,0x01,0x7F,0x23,0x04,0x23,0x04,
		0x41,0x0B,0x74,0x73,0x21,0x00,0x23,0x05,0x24,0x04,0x23,0x06,0x24,0x05,0x23,0x07,
		0x24,0x06,0x23,0x07,0x23,0x07,0x41,0x13,0x76,0x73,0x20,0x00,0x20,0x00,0x41,0x08,
		0x76,0x73,0x73,0x24,0x07,0x23,0x07,0xB8,0x0B,0x0E,0x00,0x10,0x02,0x44,0x00,0x00,
		0xE0,0xFF,0xFF,0xFF,0xEF,0x41,0xA3,0x0B,0x04,0x00,0x10,0x00,0x0B,0x02,0x00,0x0B,
		0x39,0x00,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x23,0x08,
		0x0E,0x05,0x01,0x02,0x03,0x04,0x05,0x00,0x0B,0x00,0x0B,0x41,0x00,0x21,0x00,0x0B,
		0x41,0x00,0x21,0x01,0x0B,0x41,0x00,0x21,0x02,0x0B,0x41,0x00,0x21,0x03,0x0B,0x20,
		0x00,0x20,0x01,0x20,0x02,0x20,0x03,0x10,0x01,0x0B,0x06,0x00,0x20,0x00,0x24,0x08,
		0x0B
	] ).buffer ).then( ( mod ) =>
	{
		return function( importObject = {} )
		{
			const instance = new WebAssembly.Instance( mod, {} );
			this.seed = instance.exports.seed;
			this.nextInt = instance.exports.nextInt;
			this.next = instance.exports.next;
		};
		// or
		/*
		return function( importObject = {} )
		{
			this.ready = WebAssembly.instantiate( mod, {} ).then( ( instance ) =>
			{
				this.seed = instance.exports.seed;
				this.nextInt = instance.exports.nextInt;
				this.next = instance.exports.next;
				return this;
			} );
		};
		*/
	} );
}
```

```js
CompileXorshift().then( ( Xorshift ) =>
{
	const xos = new Xorshift();
	console.log( '0x' + xos.nextInt().toString( 16 ) );
} );

// or

CompileXorshift().then( ( Xorshift ) =>
{
	const xos = new Xorshift();
	xos.ready.then( () => { console.log( '0x' + xos.nextInt().toString( 16 ) ); } );
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
