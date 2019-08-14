(module
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$viiii (func (param i32 i32 i32 i32)))
 (type $FUNCSIG$i (func (result i32)))
 (type $FUNCSIG$d (func (result f64)))
 (type $FUNCSIG$vi (func (param i32)))
 (memory $0 0)
 (table $0 1 funcref)
 (elem (i32.const 0) $null)
 (global $src/index/X i32 (i32.const 123456789))
 (global $src/index/Y i32 (i32.const 362436069))
 (global $src/index/Z i32 (i32.const 521288629))
 (global $src/index/W i32 (i32.const 88675123))
 (global $src/index/x (mut i32) (i32.const 0))
 (global $src/index/y (mut i32) (i32.const 0))
 (global $src/index/z (mut i32) (i32.const 0))
 (global $src/index/w (mut i32) (i32.const 0))
 (global $~lib/argc (mut i32) (i32.const 0))
 (export "memory" (memory $0))
 (export "X" (global $src/index/X))
 (export "Y" (global $src/index/Y))
 (export "Z" (global $src/index/Z))
 (export "W" (global $src/index/W))
 (export "__setargc" (func $~lib/setargc))
 (export "seed" (func $src/index/seed|trampoline))
 (export "nextInt" (func $src/index/nextInt))
 (export "next" (func $src/index/next))
 (start $start)
 (func $start:src/index (; 0 ;) (type $FUNCSIG$v)
  global.get $src/index/X
  global.set $src/index/x
  global.get $src/index/Y
  global.set $src/index/y
  global.get $src/index/Z
  global.set $src/index/z
  global.get $src/index/W
  global.set $src/index/w
 )
 (func $src/index/seed (; 1 ;) (type $FUNCSIG$viiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  local.get $0
  i32.eqz
  if (result i32)
   local.get $1
   i32.eqz
  else   
   i32.const 0
  end
  if (result i32)
   local.get $2
   i32.eqz
  else   
   i32.const 0
  end
  if (result i32)
   local.get $3
   i32.eqz
  else   
   i32.const 0
  end
  if
   global.get $src/index/X
   local.set $0
   global.get $src/index/Y
   local.set $1
   global.get $src/index/Z
   local.set $2
   global.get $src/index/W
   local.set $3
  end
  local.get $0
  global.set $src/index/x
  local.get $1
  global.set $src/index/y
  local.get $2
  global.set $src/index/z
  local.get $3
  global.set $src/index/w
 )
 (func $src/index/nextInt (; 2 ;) (type $FUNCSIG$i) (result i32)
  (local $0 i32)
  global.get $src/index/x
  global.get $src/index/x
  i32.const 11
  i32.shl
  i32.xor
  local.set $0
  global.get $src/index/y
  global.set $src/index/x
  global.get $src/index/z
  global.set $src/index/y
  global.get $src/index/w
  global.set $src/index/z
  global.get $src/index/w
  global.get $src/index/w
  i32.const 19
  i32.shr_u
  i32.xor
  local.get $0
  local.get $0
  i32.const 8
  i32.shr_u
  i32.xor
  i32.xor
  global.set $src/index/w
  global.get $src/index/w
 )
 (func $src/index/next (; 3 ;) (type $FUNCSIG$d) (result f64)
  call $src/index/nextInt
  f64.convert_i32_u
  f64.const 4294967295
  f64.div
 )
 (func $start (; 4 ;) (type $FUNCSIG$v)
  call $start:src/index
 )
 (func $null (; 5 ;) (type $FUNCSIG$v)
 )
 (func $src/index/seed|trampoline (; 6 ;) (type $FUNCSIG$viiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  block $4of4
   block $3of4
    block $2of4
     block $1of4
      block $0of4
       block $outOfRange
        global.get $~lib/argc
        br_table $0of4 $1of4 $2of4 $3of4 $4of4 $outOfRange
       end
       unreachable
      end
      i32.const 0
      local.set $0
     end
     i32.const 0
     local.set $1
    end
    i32.const 0
    local.set $2
   end
   i32.const 0
   local.set $3
  end
  local.get $0
  local.get $1
  local.get $2
  local.get $3
  call $src/index/seed
 )
 (func $~lib/setargc (; 7 ;) (type $FUNCSIG$vi) (param $0 i32)
  local.get $0
  global.set $~lib/argc
 )
)
