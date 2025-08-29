# Rails application generator template

## Description

The template for generating new Rails applications.

## Table of contents

* [Getting started](#getting-started)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Credits](#credits)

## Getting started

To setup development environment run `bin/setup`.

## Usage

```bash
rails new myapp -m https://raw.githubusercontent.com/infinum/rails-template/refs/heads/main/template.rb
```

## Architecture
This project aims to provide [Rails Application Template](https://guides.rubyonrails.org/rails_application_templates.html) for initializing a Rails application with the Infinum Team Rails standard settings. Entrypoint file `template.rb` is evaluated in the context of a Rails App generator, which itself is a `Thor::Group`. It

- clones this repository in a temporary directory
- adds `templates/` directory to the list of `source_paths` ([docs](https://guides.rubyonrails.org/rails_application_templates.html#advanced-usage))
- applies the `recipes/main.rb` recipe

A recipe is a file that groups related operations for a Rails Application Template.

### Post-apply instructions
In some situations (e.g., lack of information, complex configuration structure), it's more efficient for a user to manually define the configuration. Use `templates/SETUP.md` to convey the instructions that the application development team should complete after applying the template.

## Contributing

We believe that the community can help us improve and build better a product.
Please refer to our [contributing guide](CONTRIBUTING.md) to learn about the types of contributions we accept and the process for submitting them.

To ensure that our community remains respectful and professional, we defined a [code of conduct](CODE_OF_CONDUCT.md) that we expect all contributors to follow.

We appreciate your interest and look forward to your contributions.

## License

```text
Copyright 2024 Infinum

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Credits

Maintained and sponsored by [Infinum](https://infinum.com).

<div align="center">
    <a href='https://infinum.com'>
    <picture>
        <source srcset="https://assets.infinum.com/brand/logo/static/white.svg" media="(prefers-color-scheme: dark)">
        <img src="https://assets.infinum.com/brand/logo/static/default.svg">
    </picture>
    </a>
</div>
