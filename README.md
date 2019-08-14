# WebAssembly XorShift

https://docs.assemblyscript.org/

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
