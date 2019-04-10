# Brandymint static site
------

## Development

Setup development environment

> make setup

Start liveupdate development server

> make start

## Deploy

Build static distribution and deploy to server

> make 

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
