(module
    (func $hyper (param $n i32) (param $a i32) (param $b i32) (result i32) (local $res i32)
        (if (i32.eqz (local.get $n))
            (then (local.set $res (i32.add (local.get $b) (i32.const 1)))) 
            (else
                (if (i32.eqz 
                        (i32.mul 
                            (i32.eq (local.get $n) (i32.const 1)) 
                            (i32.eq (local.get $b) (i32.const 0))
                        )
                    )
                    (then
                        (if (i32.eqz 
                                (i32.mul 
                                    (i32.eq (local.get $n) (i32.const 2)) 
                                    (i32.eq (local.get $b) (i32.const 0))
                                )
                            )
                            (then
                                (if (i32.eqz
                                        (i32.mul
                                            (i32.ge_s (local.get $n) (i32.const 3))
                                            (i32.eq (local.get $b) (i32.const 0))
                                        )
                                    )
                                    (then
                                        (call $hyper
                                            (i32.add (i32.const -1) (local.get $n))
                                            (local.get $a)
                                            (call $hyper
                                                (local.get $n)
                                                (local.get $a)
                                                (i32.add (i32.const -1) (local.get $b))
                                            )
                                        )
                                        (local.set $res)
                                    ) 
                                    (else (local.set $res (i32.const 1)))
                                )
                            ) 
                            (else (local.set $res (i32.const 0)))
                        ) 
                    )
                    (else (local.set $res (local.get $a)))
                )
            )
        )
        (local.get $res)
    )
    (export "hyper" (func $hyper))
)

(;


WebAssembly.instantiateStreaming(fetch('hyper.wasm'))
  .then(obj => {
    console.log(obj.instance.exports.hyper(1, 2, 3)); 
  });


  ;)
