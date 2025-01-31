#include <vcpkg/base/basic_checks.h>
#include <vcpkg/base/stringview.h>
#include <vcpkg/base/util.h>

#include <vcpkg/commands.regenerate.h>
#include <vcpkg/configure-environment.h>
#include <vcpkg/vcpkgcmdarguments.h>

#include <array>
#include <string>
#include <vector>

namespace
{
    using namespace vcpkg;

    constexpr StringLiteral DRY_RUN = "dry-run";
    constexpr StringLiteral FORCE = "force";

    constexpr std::array<CommandSwitch, 2> command_switches = {{
        {FORCE, "proceeds with the (potentially dangerous) action without confirmation"},
        {DRY_RUN, "does not actually perform the action, shows only what would be done"},
    }};

    static const CommandStructure command_structure = {
        Strings::format("Regenerates an artifact registry.\n%s\n", create_example_string("x-regenerate")),
        1,
        1,
        {command_switches},
        nullptr,
    };
}

namespace vcpkg
{
    void RegenerateCommand::perform_and_exit(const VcpkgCmdArguments& args, const VcpkgPaths& paths) const
    {
        std::vector<std::string> forwarded_args;
        forwarded_args.push_back("regenerate");
        const auto parsed = args.parse_arguments(command_structure);
        if (Util::Sets::contains(parsed.switches, FORCE))
        {
            forwarded_args.push_back("--force");
        }

        if (Util::Sets::contains(parsed.switches, DRY_RUN))
        {
            forwarded_args.push_back("--what-if");
        }

        forwarded_args.push_back(args.command_arguments[0]);
        Checks::exit_with_code(VCPKG_LINE_INFO, run_configure_environment_command(paths, forwarded_args));
    }
}
