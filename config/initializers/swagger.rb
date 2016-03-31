if defined? GrapeSwaggerRails
  GrapeSwaggerRails.options.url      = '/api/api.json'
  
  GrapeSwaggerRails.options.before_filter_proc = proc {
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
}
  
  GrapeSwaggerRails.options.doc_expansion = 'list'
  GrapeSwaggerRails.options.app_name = 'Coin Pocket'
  GrapeSwaggerRails.options.app_url  = '/'
 end