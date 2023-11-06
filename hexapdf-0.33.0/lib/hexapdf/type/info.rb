# -*- encoding: utf-8; frozen_string_literal: true -*-
#
#--
# This file is part of HexaPDF.
#
# HexaPDF - A Versatile PDF Creation and Manipulation Library For Ruby
# Copyright (C) 2014-2023 Thomas Leitner
#
# HexaPDF is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License version 3 as
# published by the Free Software Foundation with the addition of the
# following permission added to Section 15 as permitted in Section 7(a):
# FOR ANY PART OF THE COVERED WORK IN WHICH THE COPYRIGHT IS OWNED BY
# THOMAS LEITNER, THOMAS LEITNER DISCLAIMS THE WARRANTY OF NON
# INFRINGEMENT OF THIRD PARTY RIGHTS.
#
# HexaPDF is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public
# License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with HexaPDF. If not, see <http://www.gnu.org/licenses/>.
#
# The interactive user interfaces in modified source and object code
# versions of HexaPDF must display Appropriate Legal Notices, as required
# under Section 5 of the GNU Affero General Public License version 3.
#
# In accordance with Section 7(b) of the GNU Affero General Public
# License, a covered work must retain the producer line in every PDF that
# is created or manipulated using HexaPDF.
#
# If the GNU Affero General Public License doesn't fit your need,
# commercial licenses are available at <https://gettalong.at/hexapdf/>.
#++

require 'hexapdf/dictionary'

module HexaPDF
  module Type

    # Represents the PDF's document information dictionary.
    #
    # The info dictionary is linked via the /Info entry from the Trailer and contains metadata for
    # the document.
    #
    # See: PDF2.0 s14.3.3, Trailer
    class Info < Dictionary

      define_type :XXInfo

      define_field :Title,        type: String, version: '1.1'
      define_field :Author,       type: String
      define_field :Subject,      type: String, version: '1.1'
      define_field :Keywords,     type: String, version: '1.1'
      define_field :Creator,      type: String
      define_field :Producer,     type: String
      define_field :CreationDate, type: PDFDate
      define_field :ModDate,      type: PDFDate
      define_field :Trapped,      type: Symbol, version: '1.3',
        allowed_values: [:True, :False, :Unknown]

      # Info dictionaries must always be indirect.
      def must_be_indirect?
        true
      end

    end

  end
end
