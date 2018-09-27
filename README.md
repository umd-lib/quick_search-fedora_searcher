# quick_search-fedora_searcher

Searcher for NCSU Quick Search that searches Fedora 4 databases via the Hippo CMS.

## Installation

Include the searcher gem in your Gemfile:

```
gem 'quick_search-fedora_searcher'
```

Run bundle install:

```
bundle install
```

Include in your Search Results page

```
<%= render_module(@fedora, 'fedora') %>
```

## Configuration

The Fedora searcher requires configuration, such as specific URL to
use in retrieving search results. To set the configuration, create a
"config/searchers/" directory in your application (the "searchers" subdirectory
may need to be created), and copy the "config/fedora_config.yml" file
in this gem into it. Follow the instructions in the file to configure the
searcher.

Additional customizations can be done by editing the "config/locales/en.yml" file
