module ShopifyAPI
  class Comment < Base
    def remove;   load_attributes_from_response(post(:remove, {}, only_id)); end
    def ham;      load_attributes_from_response(post(:ham, {}, only_id)); end
    def spam;     load_attributes_from_response(post(:spam, {}, only_id)); end
    def approve;  load_attributes_from_response(post(:approve, {}, only_id)); end
    def restore;  load_attributes_from_response(post(:restore, {}, only_id)); end
    def not_spam; load_attributes_from_response(post(:not_spam, {}, only_id)); end

    def only_id
      encode(:only => :id)
    end
  end
end
