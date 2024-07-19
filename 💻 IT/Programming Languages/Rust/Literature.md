Beyond that, there's the https://lborb.github.io/book/. I'd specifically suggest the following things listed in it:
- **Rust by Example** (As a supplement to The Book if you want more example-based learning)
- **Learn Rust With Entirely Too Many Linked Lists** (To improve your understanding of what Rust's ownership-and-borrowing paradigm means for writing data structures)
- **Rust Design Patterns**
- **The Rust Performance Book** (This covers stuff like how Rust's I/O isn't buffered by default like it is in many languages, so you need to use BufReader and BufWriter or something else equivalent but more suited to specialzed use-cases, as well as how things like println! will acquire and release the lock on stdout/stderr/etc. each time as a compromise for allowing multiple threads to output without garbling each other's messages so, if you're bottlenecking on that, you should acquire the lock manually and hold it until you're done. It also discusses memory requirements as a form of performance optimization.)
- If you're OK with paying for books, O'Reilly's **Programming Rust** by Blandy, Orendorff, and Tindall is also commonly recommended as a supplement or alternative to The Book since a lot of people say that it improved their understanding of intermediate-level knowledge over just The Book.
- I also highly recommend using `cargo clippy` to check your code and then reading the documentation links for any lints that trip. Clippy is great at teaching you to write more idiomatic Rust code.

If you're coming from a VMed language... and especially one that bet as heavily on "Everything is a reference. Let the GC figure it out" as the JVM did, then I'd also recommend these two resources:
- code::dive conference 2014 - **Scott Meyers: Cpu Caches and Why You Care**
- **The Lost Art of Structure Packing** by Eric S. Raymond (Rust normally does this for you, but it's useful to know what it's doing, as well as for if you use #[repr(C)])

Also, to go really tangential, you may find these useful to better understand the why of things Rust may inspire you to try your hand at:
- **Command Line Interface Guidelines**
- **The TTY Demystified** by Linus Åkesson
- **Things Every Hacker Once Knew** by Eric S. Raymond (Also, if the ASCII part piques your curiosity, see Aivosto's Control characters in ASCII and Unicode)
- **The Art of Unix Programming** by Eric S. Raymond (The free online version of a book from 2003 that's still surprisingly relevant now, which explains why so much Linux/BSD stuff is designed the way it is. Downloadable eBook versions are available on The Internet Archive.)

Finally, here's a previous post of mine where I suggest some good Rust crates and you may also want to check out Rust Interop and Are We Extending Yet? for lists of crates that make it easier to incorporate Rust into Java projects.

For me, being able to easily write Rust modules for Python projects using rust-cpython (I started back before PyO3 was forked off from it) was one of the big things that drew me to the language.