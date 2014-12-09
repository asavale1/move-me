module Util
	def self.cmd(cmd, cwd)
		result = `cd #{cwd}; #{cmd} 2>&1`
		return result, $!
	end
end