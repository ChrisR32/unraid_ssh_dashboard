get_cpu_info = {"lscpu" => "Short summary of CPU info", "cat /proc/cpuinfo" => "Much longer report of all CPUs", "egrep --color 'lm|vmx|svm' /proc/cpuinfo" => "Check for 64bit mode support and CPU virtualization support"}

def make_into_list (stuff)

end

make_into_list(get_cpu_info)