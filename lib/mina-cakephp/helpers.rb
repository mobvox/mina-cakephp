module MinaCakePHP
  
  def cake_cmd (cmd)
    real_cmd = "yes | " + cake_console_path + " #{cmd}"

    queue %{
      echo "-----> Running CakePHP script 'cake #{cmd}'"
        #{echo_cmd real_cmd} &&
        echo "-----> Done."
      }
  end

  def cake_console_path
    cake_path + "/lib/Cake/Console/cake"
  end
end