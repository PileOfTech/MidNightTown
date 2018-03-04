app.config [
  '$compileProvider'
  ($compileProvider) ->
    $compileProvider.debugInfoEnabled true
    return
]

# Общий конфиг для всех инстансов app (application, devise)
app.run [
  '$rootScope', '$timeout'
  ($rootScope,  $timeout) ->
    $rootScope.Routes = Routes


    _.mixin getDecimal: (num) ->
      (num + '').split('.')[1]

    _.mixin humanFilename: (filename) ->
      filename.replace(/\.[^\.]+$/g, "").replace(/_/g, ' ')

    _.mixin compactObject: (o) ->
      clone = _.clone(o)
      _.each clone, (v, k) ->
        if v == undefined or _.isNull(v)
          delete clone[k]
        return
      clone

    _.mixin CSVtoArray: (text) ->
      re_valid = /^\s*(?:'[^'\\]*(?:\\[\S\s][^'\\]*)*'|"[^"\\]*(?:\\[\S\s][^"\\]*)*"|[^,'"\s\\]*(?:\s+[^,'"\s\\]+)*)\s*(?:,\s*(?:'[^'\\]*(?:\\[\S\s][^'\\]*)*'|"[^"\\]*(?:\\[\S\s][^"\\]*)*"|[^,'"\s\\]*(?:\s+[^,'"\s\\]+)*)\s*)*$/
      re_value = /(?!\s*$)\s*(?:'([^'\\]*(?:\\[\S\s][^'\\]*)*)'|"([^"\\]*(?:\\[\S\s][^"\\]*)*)"|([^,'"\s\\]*(?:\s+[^,'"\s\\]+)*))\s*(?:,|$)/g
      if !re_valid.test(text)
        return null
      a = []
      text.replace re_value, (m0, m1, m2, m3) ->
        if m1 != undefined
          a.push m1.replace(/\\'/g, '\'')
        else if m2 != undefined
          a.push m2.replace(/\\"/g, '"')
        else if m3 != undefined
          a.push m3
        ''
      if /,\s*$/.test(text)
        a.push ''
      a

    return
]


# © Rnd-Soft (Рнд Софт), 2017
