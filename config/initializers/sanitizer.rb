Sanitize::Rails.configure(
  # elements: %w[ a p ],
  elements: ['<a>'],
  # attributes: {},
)



# Sanitize::Rails.configure(
#   :elements => %w[ a b blockquote br div img em i li ol p span strong u ul ],

#   :attributes => {
#     :all  => ['style'],
#     'a'   => ['href'],
#     'img' => ['src']
#   },

#   :add_attributes => {
#     'a' => {
#       'rel'    => 'nofollow',
#       'target' => '_blank'
#     }
#   },

#   :protocols => {
#     'a' => {'href' => ['ftp', 'http', 'https', 'mailto', :relative]},
#     'img' => {'src' => ['http', 'https']}
#   },

#   :transformers => [css_sanitizer, div_transformer, ie_cleaner],

#   :whitespace_elements => %w(
#     address article aside blockquote dd dl dt footer
#     h1 h2 h3 h4 h5 h6 header hgroup hr nav pre section
#     tr td option input
#   )
# )
