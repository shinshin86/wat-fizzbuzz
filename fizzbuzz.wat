(module
  ;; To output according to each type
  (import "console" "log" (func $logStr(param externref)))
  (import "console" "log" (func $logNum(param i32)))
  (func $display (param $n i32) (param $fizz externref) (param $buzz externref) (param $fizzbuzz externref)
    ;; Fizz, Buzz, Fizz Buzz, if none of the above apply, branch the process to output numerical values using flags
    (local $fbFlag i32)

    (if (i32.eq (i32.rem_u (local.get $n)(i32.const 15))(i32.const 0))
      (then
        (local.get $fizzbuzz)
        (call $logStr)
        (local.set $fbFlag (i32.const 1))
      )
    )

    (if (i32.eq (i32.rem_u (local.get $n)(i32.const 5))(i32.const 0))
      (then
        (local.get $buzz)
        (call $logStr)
        (local.set $fbFlag (i32.const 1))
      )
    )

    (if (i32.eq (i32.rem_u (local.get $n)(i32.const 3))(i32.const 0))
      (then
        (local.get $fizz)
        (call $logStr)
        (local.set $fbFlag (i32.const 1))
      )
    )

    (local.get $fbFlag)
    (if
      (then)
      (else
        (local.get $n)
        (call $logNum)
      )
    )
  )

  (func $fizzbuzz (param $fizz externref) (param $buzz externref) (param $fizzbuzz externref)
    ;; Define $i as a variable. Initial value is 0
    (local $i i32)

    (loop $my_loop

      ;; Add 1 for $i
      local.get $i
      i32.const 1
      i32.add
      local.set $i

      ;; Put parameters passed to the display function on the stack before calling the function
      local.get $i
      local.get $fizz
      local.get $buzz
      local.get $fizzbuzz
      call $display

      ;; If the value of $i is less than 100, loop again
      local.get $i
      i32.const 100
      i32.lt_s
      br_if $my_loop
    )
  )
  (export "fizzbuzz" (func $fizzbuzz))
)