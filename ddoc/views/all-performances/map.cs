(doc) ->
  for perf in doc.shows
    emit [perf.slot,doc.venue],[doc.name,doc._id]