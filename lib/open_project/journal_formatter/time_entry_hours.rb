#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

class OpenProject::JournalFormatter::TimeEntryHours < JournalFormatter::Base
  def render(_key, values, options = { html: true })
    label_text = I18n.t('activerecord.attributes.project.public_value.title')
    label_text = 'Spent time'
    label_text << ':' if !values.first
    label_text = content_tag(:strong, label_text) if options[:html]

    # TODO - Italicize
    # Mismatch between @event.event_path and linked WP in item_component???

    first = (values.first % 1).zero? ? values.first.to_i : values.first if values.first
    last = (values.last % 1).zero? ? values.last.to_i : values.last

    # TODO - Refactor?
    value = \
      if values.first
        if values.first == 1
          I18n.t(:'activity.item.time_entry.updated_first_single',
                              first: first,
                              last: last)
        elsif values.last == 1
          I18n.t(:'activity.item.time_entry.updated_last_single',
                              first: first,
                              last: last)
        else
          I18n.t(:'activity.item.time_entry.updated',
                             first: first,
                             last: last)
        end
      else
        if values.last == 1
          I18n.t(:'activity.item.time_entry.created_single',
                             last: last)
        else
          I18n.t(:'activity.item.time_entry.created',
                             last: last)
        end
      end
    # value = content_tag(:i, value) if options[:html]

    I18n.t(:text_journal_of, label: label_text, value:)
  end
end
