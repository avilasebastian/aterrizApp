package ui.aplicacion

import org.mongodb.morphia.mapping.cache.EntityCacheFactory
import org.mongodb.morphia.mapping.cache.EntityCache
import org.mongodb.morphia.mapping.cache.DefaultEntityCache

class MiCacheFactory implements EntityCacheFactory {
	var EntityCache entityCache

	new() {
		this.dropCache()
	}

	override EntityCache createCache() {
		entityCache
	}

	def void dropCache() {
		this.entityCache = new DefaultEntityCache()
	}
}
