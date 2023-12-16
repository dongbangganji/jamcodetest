<?php

namespace App\Domain;

class FitnessCoach implements FitnessCoachInterface
{
    public function recommendSolution($lifestyleTags): string
    {
        $key = config("serviceName.notFound");
        $lifestyleTags = (array)$lifestyleTags;
        foreach (config('fitness') as $k => $v) {
            if (count(array_diff($v, $lifestyleTags)) === 0 && count(array_diff($lifestyleTags, $v)) === 0) {
                $key = $k;
                break;
            }
        }
        return $key;
    }
}
