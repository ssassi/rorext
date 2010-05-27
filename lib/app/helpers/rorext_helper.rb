module RorextHelper

  # Creates a data store for extjs with a +store_id+ variable name
  #
  # ==== Signatures
  #
  #   rorext_datastore(store_id, entity, data_or_class)
  #
  # ==== Options
  #
  # ==== Examples
  # rorext_datastore can receive an array with attribute names, or an Active Record class and extract the attributes automatically
  #
  #   rorext_datastore :store, @person, Person
  #   rorext_datastore :store, @person, [:id, :name, :last_name]
  #   rorext_datastore :store, @person, [{:attribute => :document, :index => :document, :id => true}, :name, :last_name]
  def rorext_datastore(store_id, entity, data)
    data = generate_data(data) if data.superclass && data.superclass == ActiveRecord::Base
    id_index = id_index(data)
    index_names = index_names(data, id_index).compact
    values = data_values(data, entity)
    return "var " + store_id.to_s + " = new Ext.data.Store({ data: " + values.to_json + ", reader: new Ext.data.ArrayReader({id:'" +
            id_index.to_s + "'}, [" + index_names.collect{|b|"'"+b+"'"}.join(',') + "])});"
  end
    
  private
  def generate_data(_class)
    pk = _class.primary_key
    _class.new.attributes.keys << {:attribute => pk, :index => pk, :id => true}
  end

  def data_values(data, entity)
    values = []
    entity.each do |r|
      record = []
      data.each do |d|
        if d.is_a?(Hash)
          record << r.send(d.with_indifferent_access[:attribute])
        else
          record << r.send(d)
        end  
      end
      values << record
    end
    values
  end

  def index_names(data, id_index=nil)
    data.collect do |element|
      if element.is_a?(Hash)
        id = element.with_indifferent_access[:index]
        id.to_s unless id == id_index
      else
        element.to_s unless element == id_index
      end
    end
  end

  def id_index(data)
    data.each do |element|
      if element.is_a?(Hash)
        unless element.with_indifferent_access[:id].blank?
          return element.with_indifferent_access[:index]
        end
      end
    end
    index_names(data)[0]
  end

end