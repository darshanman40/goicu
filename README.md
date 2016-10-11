This work is mainly for embedding ICU57 into your Go application.

To use this lib, include the following in your Go lib which needs to use ICU:

```
// #cgo CPPFLAGS: -I${SRCDIR}/icu/icuembed -DU_DISABLE_RENAMING=1
// #cgo darwin LDFLAGS: -Wl,-undefined -Wl,dynamic_lookup
// #cgo !darwin LDFLAGS: -Wl,-unresolved-symbols=ignore-all -lrt
import "C"

import (
	"github.com/dgraph-io/goicu/icuembed"
)
```

And you will need to call this somewhere, e.g., `init()`:

```
icuembed.Load(filename)
```

where filename points to where your ICU data file is. It is included in this repo:

```
https://github.com/dgraph-io/goicu/blob/master/icudt57l.dat
```

We will add some tests soon. We do test it indirectly in
`github.com/dgraph-io/dgraph/tok`.