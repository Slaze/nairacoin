set(gen_genesis_sources gen_genesis.cpp)

monero_add_executable(gen_genesis ${gen_genesis_sources})
target_link_libraries(gen_genesis
  PRIVATE
    cryptonote_core
    cryptonote_basic
    cncrypto
    common
    epee
    version
    ${Boost_CHRONO_LIBRARY}
    ${Boost_FILESYSTEM_LIBRARY}
    ${Boost_PROGRAM_OPTIONS_LIBRARY}
    ${Boost_THREAD_LIBRARY}
    ${CMAKE_THREAD_LIBS_INIT}
    ${EXTRA_LIBRARIES})
add_dependencies(gen_genesis version)
set_property(TARGET gen_genesis PROPERTY OUTPUT_NAME "nairacoin-gen-genesis")
install(TARGETS gen_genesis DESTINATION bin)
