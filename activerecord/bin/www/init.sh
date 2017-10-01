#!/bin/bash
rails db:create && \
rails db:migrate && \
rails assets:precompile && \
foreman start
