(deftem foo field1 'default)
(= f inst!foo)

(test-iso "templates pick up defaults"
  'default
  f!field1)

(= f!field1 34)
(test-iso "reading and assigning templates works"
  34
  f!field1)

(= f!field1 nil)
(test-iso "assigning templates to nil works"
  nil
  f!field1)

(test-iso "temlist works"
  '((field1 34))
  (temlist 'foo (inst 'foo 'field1 34)))

(test-iso "temlist sets missing fields to nil"
  '((field1 nil))
  (temlist 'foo (inst 'foo 'field1 nil)))

(test-iso "listtem DOES NOT ignore unknown fields"
  (inst 'foo 'new-field 34)
  (listtem 'foo '((new-field 34))))

(test-iso "temlist and listtem are converses"
  (inst 'foo 'field1 34)
  (listtem 'foo (temlist 'foo (inst 'foo 'field1 34))))

(test-iso "temread and temwrite are converses"
  (inst 'foo 'field1 34)
  (w/instring i (w/outstring o
                  (temwrite 'foo (inst 'foo 'field1 34) o)
                  (inside o))
    (temread 'foo i)))

(test-iso "temread and temwrite are converses - 2"
  (inst 'foo 'field1 nil)
  (w/instring i (w/outstring o
                  (temwrite 'foo (inst 'foo 'field1 nil) o)
                  (inside o))
    (temread 'foo i)))

(test-iso "nil in file overwrites default"
  nil
  (w/instring i (w/outstring o
                  (temwrite 'foo (inst 'foo 'field1 nil) o)
                  (inside o))
    ((temread 'foo i) 'field1)))

(test-iso "templates can distinguish explicit defaults from implicit defaults"
  (obj field1 'default)
  (let tem (inst 'foo)
    (= tem!field1 34)
    (= tem!field1 'default) ; explicit set
    rep.tem.1))
