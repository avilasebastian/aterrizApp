db.newHistorial.aggregate([
	{$group: {
		_id: {destino: '$destino'},
		suma: {$sum: 1}
	}},
	{$group: {
		_id: 0,
		suma: {$max: '$suma'}
	}}
])
