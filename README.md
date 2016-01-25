# Brandymint static site
------

## Development

`bundle install` first.

`bundle exec middleman` starts a server on `0.0.0.0:4567` (liveupdate included).

`bundle exec middleman build` builds a static site in `build` folder.

`cap production deploy`

---

## Data and content

`models` folder contains models.

Data is stored in `data` folder in .yml files — *in process*

Access data in templates with `= data.yml_file.key...` objects, like `= data.projects.first.title`

---

## What to do?
- Migrate all data to yml
- Large texts in markdown (use redcarpet)
- Locale switch
- Russian content
