<?php

namespace Tests\Unit;

//use PHPUnit\Framework\TestCase;
use App\Domain\DietExpert;
use Tests\TestCase;

class dietExpertTest extends TestCase
{
    public function testDietExpert()
    {
        $result = true;
        $rules = config('diet');
        $dietExpert = new DietExpert();
        foreach ($rules as $value) {
            $value = $dietExpert->recommendSolution((object)$value);
            if ($value === 'not_found') {
                $result = [false, "정책이 변경 확인 필요"];
            }
        }
        $this->assertTrue($result);
    }
}
