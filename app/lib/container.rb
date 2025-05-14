class Container
    @map = {}
    private_class_method :new

    def self.get(key)
      @map[key]
    end

    def self.register(key, service)
        @map[key] = service
    end

    def self.unregister(key)
        @map.delete(key)
    end
end
