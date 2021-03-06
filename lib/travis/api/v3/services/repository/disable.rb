module Travis::API::V3
  class Services::Repository::Disable < Service
    def run!(activate = false)
      repository = check_login_and_find(:repository)
      check_access(repository)

      admin = access_control.admin_for(repository)

      github(admin).set_hook(repository, activate)
      repository.update_attributes(active: activate)

      repository
    end

    def check_access(repository)
      access_control.permissions(repository).disable!
    end
  end
end
