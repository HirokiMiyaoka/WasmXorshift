(module
 (type $iiiiii (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $iiiiiv (func (param i32 i32 i32 i32 i32)))
 (type $ii (func (param i32) (result i32)))
 (type $iF (func (param i32) (result f64)))
 (global $XorShift.X (mut i32) (i32.const 123456789))
 (global $XorShift.Y (mut i32) (i32.const 362436069))
 (global $XorShift.Z (mut i32) (i32.const 521288629))
 (global $XorShift.W (mut i32) (i32.const 88675123))
 (memory $0 1)
 (export "XorShift#seed" (func $XorShift#seed))
 (export "XorShift" (func $XorShift))
 (export "XorShift#nextInt" (func $XorShift#nextInt))
 (export "XorShift#next" (func $XorShift#next))
 (export "memory" (memory $0))
 (func $XorShift#seed (type $iiiiiv) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (if
   (select
    (i32.ne
     (i32.eqz
      (get_local $4)
     )
     (i32.const 0)
    )
    (i32.const 0)
    (i32.ne
     (select
      (i32.ne
       (i32.eqz
        (get_local $3)
       )
       (i32.const 0)
      )
      (i32.const 0)
      (i32.ne
       (select
        (i32.ne
         (i32.eqz
          (get_local $2)
         )
         (i32.const 0)
        )
        (i32.const 0)
        (i32.ne
         (i32.eqz
          (get_local $1)
         )
         (i32.const 0)
        )
       )
       (i32.const 0)
      )
     )
     (i32.const 0)
    )
   )
   (block
    (set_local $1
     (get_global $XorShift.X)
    )
    (set_local $2
     (get_global $XorShift.Y)
    )
    (set_local $3
     (get_global $XorShift.Z)
    )
    (set_local $4
     (get_global $XorShift.W)
    )
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (i32.store offset=8
   (get_local $0)
   (get_local $3)
  )
  (i32.store offset=12
   (get_local $0)
   (get_local $4)
  )
 )
 (func $XorShift (type $iiiiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (result i32)
  (call $XorShift#seed
   (get_local $0)
   (get_local $1)
   (get_local $2)
   (get_local $3)
   (get_local $4)
  )
  (return
   (get_local $0)
  )
 )
 (func $XorShift#nextInt (type $ii) (param $0 i32) (result i32)
  (local $1 i32)
  (set_local $1
   (i32.xor
    (i32.load
     (get_local $0)
    )
    (i32.shl
     (i32.load
      (get_local $0)
     )
     (i32.const 11)
    )
   )
  )
  (i32.store
   (get_local $0)
   (i32.load offset=4
    (get_local $0)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.load offset=8
    (get_local $0)
   )
  )
  (i32.store offset=8
   (get_local $0)
   (i32.load offset=12
    (get_local $0)
   )
  )
  (i32.store offset=12
   (get_local $0)
   (i32.xor
    (i32.xor
     (i32.load offset=12
      (get_local $0)
     )
     (i32.shr_u
      (i32.load offset=12
       (get_local $0)
      )
      (i32.const 19)
     )
    )
    (i32.xor
     (get_local $1)
     (i32.shr_u
      (get_local $1)
      (i32.const 8)
     )
    )
   )
  )
  (return
   (i32.load offset=12
    (get_local $0)
   )
  )
 )
 (func $XorShift#next (type $iF) (param $0 i32) (result f64)
  (return
   (f64.div
    (f64.convert_u/i32
     (call $XorShift#nextInt
      (get_local $0)
     )
    )
    (f64.const 4294967295)
   )
  )
 )
)
