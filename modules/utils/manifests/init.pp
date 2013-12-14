
class utils {

    import "definitions/*.pp"

    anchor { 'utils::begin': }
    anchor { 'utils::end': }

    Anchor['utils::begin']
        -> Anchor['utils::end']

}
