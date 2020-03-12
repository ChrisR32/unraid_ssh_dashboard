def get_tool_list(tool)
when tool == 'CPU' do puts get_cpu_info
when tool == 'Memory' do puts get_mem_info
when tool == 'Virtual Memory' do puts get_virt_mem_info
when tool == 'Networking' do puts get_eth_info
when tool == 'Hard drives' do puts get_hdd_info
when tool == 'Admin scan tool' do puts get_mgr_info
when tool == 'Version info' do puts get_ver_info
when tool == 'Misc Hardware' do puts get_othr_info
when tool == 'Sensors' do puts get_sens_info
when tool == 'Live Info' do puts get_live_info
end