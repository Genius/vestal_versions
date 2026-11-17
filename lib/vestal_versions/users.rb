module VestalVersions
  # Provides a way for information to be associated with specific versions as to who was
  # responsible for the associated update to the parent.
  module Users
    extend ActiveSupport::Concern

    included do
      attr_accessor :updated_by
      Version.class_eval{ include UsersMethods }
    end

    # Methods added to versioned ActiveRecord::Base instances to enable versioning with additional
    # user information.
    
    
    private
    # Overrides the +version_attributes+ method to include user information passed into the
    # parent object, by way of a +updated_by+ attr_accessor.
    def version_attributes
      super.merge(:user => updated_by)
    end
  end

  # Instance methods added to VestalVersions::Version to accomodate incoming user information.
  module UsersMethods
    extend ActiveSupport::Concern

    included do
      user_options = { :polymorphic => true }
      user_options[:optional] = true if ActiveRecord::VERSION::MAJOR >= 5

      belongs_to :user, user_options

      prepend UserName
    end

    # Overrides the +user+ and +user=+ methods created by the polymorphic +belongs_to+ user
    # association.
    module UserName
      # If the association is absent, defaults to the +user_name+ string column. This allows
      # VestalVersions::Version#user to either return an ActiveRecord::Base object or a string,
      # depending on what is sent to the +user=+ method.
      def user
        super || user_name
      end

      # Based on the class of the object given, either the +user+ association columns or the
      # +user_name+ string column is populated.
      def user=(value)
        case value
          when ActiveRecord::Base then super
          else self.user_name = value
        end
      end
    end

  end
end
