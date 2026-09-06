A Github Pages template for academic websites. This was forked (then detached) by [Stuart Geiger](https://github.com/staeiou) from the [Minimal Mistakes Jekyll Theme](https://mmistakes.github.io/minimal-mistakes/), which is © 2016 Michael Rose and released under the MIT License. See LICENSE.md.

I think I've got things running smoothly and fixed some major bugs, but feel free to file issues or make pull requests if you want to improve the generic template / theme.

### Note: if you are using this repo and now get a notification about a security vulnerability, delete the Gemfile.lock file. 

# Instructions

1. Register a GitHub account if you don't have one and confirm your e-mail (required!)
1. Fork [this repository](https://github.com/academicpages/academicpages.github.io) by clicking the "fork" button in the top right. 
1. Go to the repository's settings (rightmost item in the tabs that start with "Code", should be below "Unwatch"). Rename the repository "[your GitHub username].github.io", which will also be your website's URL.
1. Set site-wide configuration and create content & metadata (see below -- also see [this set of diffs](http://archive.is/3TPas) showing what files were changed to set up [an example site](https://getorg-testacct.github.io) for a user with the username "getorg-testacct")
1. Upload any files (like PDFs, .zip files, etc.) to the files/ directory. They will appear at https://[your GitHub username].github.io/files/example.pdf.  
1. Check status by going to the repository settings, in the "GitHub pages" section
1. (Optional) Use the Jupyter notebooks or python scripts in the `markdown_generator` folder to generate markdown files for publications and talks from a TSV file.

See more info at https://academicpages.github.io/

## To run locally (not on GitHub Pages, to serve on your own computer)

### Linux

1. Clone the repository and made updates as detailed above
1. Make sure you have ruby-dev, bundler, and nodejs installed: `sudo apt install ruby-dev ruby-bundler nodejs`
1. Run `bundle clean` to clean up the directory (no need to run `--force`)
1. Run `bundle install` to install ruby dependencies. If you get errors, delete Gemfile.lock and try again.
1. Run `bundle exec jekyll liveserve` to generate the HTML and serve it from `localhost:4000` the local server will automatically rebuild and refresh the pages on change.

### macOS

macOS ships its own Ruby (2.6) which this repo's `Gemfile.lock` is pinned to, but two OS-level quirks get in the way of a plain `bundle install` / `jekyll serve`:

1. **Native gem compile error (`config.h` missing for `universal-darwinNN`)** — happens when the Xcode Command Line Tools are older than your current macOS version, so their bundled Ruby SDK headers don't have a folder matching your OS's Darwin version. Check the version Ruby is looking for with `ruby -e 'puts RbConfig::CONFIG["arch"]'`, find the folder that *does* exist under:
   `/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/Ruby.framework/Versions/2.6/usr/include/ruby-2.6.0/`
   and symlink the missing one to it, e.g. if `universal-darwin23` exists but `universal-darwin24` is needed:
   ```bash
   sudo ln -s .../ruby-2.6.0/universal-darwin23 .../ruby-2.6.0/universal-darwin24
   ```
   (This is safe and reversible — remove the symlink with `sudo rm` to undo it.)
1. **`Invalid US-ASCII character` error from `jekyll serve`** — your shell's locale isn't set to UTF-8. Export it before running any Jekyll commands: `export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8`.

Steps:

1. Clone the repository and make updates as detailed above.
1. Apply the Xcode CLT symlink workaround above if `bundle install` fails with a `config.h` / native extension build error.
1. Install gems into the project folder (keeps them out of system Ruby): `bundle install --path vendor/bundle`
1. `export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8`
1. Run `bundle exec jekyll serve --port 4001` (use `--port` to pick any free port) to generate the HTML and serve it at `localhost:4001`.
   - Note: `bundle exec jekyll liveserve` (via the `hawkins` gem) crashes on this Ruby/Jekyll combo with a `NoMethodError` in `conditionally_inject_charset` — use plain `jekyll serve` instead. This means no auto-reload: after editing content, save the file and refresh the browser tab (Jekyll rebuilds the site automatically on save; you just won't get a live-reload push).
1. To stop the server later: `pkill -f "jekyll serve"`.

# Changelog -- bugfixes and enhancements

There is one logistical issue with a ready-to-fork template theme like academic pages that makes it a little tricky to get bug fixes and updates to the core theme. If you fork this repository, customize it, then pull again, you'll probably get merge conflicts. If you want to save your various .yml configuration files and markdown files, you can delete the repository and fork it again. Or you can manually patch. 

To support this, all changes to the underlying code appear as a closed issue with the tag 'code change' -- get the list [here](https://github.com/academicpages/academicpages.github.io/issues?q=is%3Aclosed%20is%3Aissue%20label%3A%22code%20change%22%20). Each issue thread includes a comment linking to the single commit or a diff across multiple commits, so those with forked repositories can easily identify what they need to patch.
